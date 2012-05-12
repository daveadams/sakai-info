# sakai-info/gradebook.rb
#   SakaiInfo::Gradebook library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-05-12 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Gradebook < SakaiObject
    attr_reader :version, :site_id, :name

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(dbrow)
      @dbrow = dbrow

      @id = @dbrow[:id].to_i
      @version = @dbrow[:version].to_i
      @site_id = @dbrow[:gradebook_uid]
      @name = @dbrow[:name]
    end

    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:gb_gradebook_t].where(:id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(Gradebook, id)
        end

        @@cache[id] = Gradebook.new(row)
      end
      @@cache[id]
    end

    def site
      @site ||= Site.find(self.site_id)
    end

    def self.query_by_site_id(site_id)
      DB.connect[:gb_gradebook_t].where(:gradebook_uid => site_id)
    end

    def self.count_by_site_id(site_id)
      Gradebook.query_by_site_id(site_id).count
    end

    def self.find_by_site_id(site_id)
      Gradebook.query_by_site_id(site_id).all.collect { |row| Gradebook.new(row) }
    end

    def items
      @items ||= GradebookItem.find_by_gradebook_id(self.id)
    end

    def item_count
      @item_count ||= GradebookItem.count_by_gradebook_id(self.id)
    end

    def default_serialization
      {
        "id" => self.id,
        "name" => self.name,
        "site" => self.site.serialize(:summary),
        "version" => self.version,
        "item_count" => self.item_count,
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "name" => self.name,
        "site_id" => self.site_id,
        "item_count" => self.item_count,
      }
    end

    def site_summary_serialization
      {
        "id" => self.id,
      }
    end

    def items_serialization
      {
        "items" => self.items.collect { |item| item.serialize(:summary) }
      }
    end

    def self.all_serializations
      [
       :default,
       :items
      ]
    end
  end

  class GradebookItem < SakaiObject
    attr_reader :gradebook_id, :object_type_id, :version, :name, :points_possible, :due_date, :weight

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(dbrow)
      @dbrow = dbrow

      @id = @dbrow[:id]
      @gradebook_id = @dbrow[:gradebook_id].to_i
      @object_type_id = @dbrow[:object_type_id].to_i
      @version = @dbrow[:version].to_i
      @name = @dbrow[:name]
      @points_possible = @dbrow[:points_possible].to_f
      @due_date = @dbrow[:due_date]
      @weight = @dbrow[:assignment_weighting].to_f
    end

    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:gb_gradable_object_t].where(:id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(GradebookItem, id)
        end
        @@cache[id] = GradebookItem.new(row)
      end
      @@cache[id]
    end

    def gradebook
      @gradebook = Gradebook.find(self.gradebook_id)
    end

    def self.query_by_gradebook_id(gradebook_id)
      DB.connect[:gb_gradable_object_t].where(:gradebook_id => gradebook_id)
    end

    def self.count_by_gradebook_id(gradebook_id)
      GradebookItem.query_by_gradebook_id(gradebook_id).count
    end

    def self.find_by_gradebook_id(gradebook_id)
      GradebookItem.query_by_gradebook_id(gradebook_id).all.collect { |row| GradebookItem.new(row) }
    end

    def default_serialization
      result = {
        "id" => self.id,
        "name" => self.name,
        "gradebook_id" => self.gradebook_id,
        "object_type_id" => self.object_type_id,
        "version" => self.version,
        "points_possible" => self.points_possible,
        "due_date" => self.due_date,
        "weight" => self.weight
      }
      if self.due_date.nil?
        result.delete("due_date")
      end
      result
    end

    def summary_serialization
      result = {
        "id" => self.id,
        "name" => self.name,
        "points_possible" => self.points_possible,
        "due_date" => self.due_date
      }
      if self.due_date.nil?
        result.delete("due_date")
      end
      result
    end
  end
end

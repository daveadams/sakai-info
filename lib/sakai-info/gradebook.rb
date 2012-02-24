# sakai-info/gradebook.rb
#   SakaiInfo::Gradebook library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-24 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Gradebook < SakaiObject
    attr_reader :version, :site, :name

    def initialize(id, version, site, name)
      @id = id
      @version = version
      @site = site
      @name = name
    end

    @@cache = {}
    @@cache_by_site_id = {}
    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect.fetch("select version, gradebook_uid, name " +
                               "from gb_gradebook_t " +
                               "where id = :id", id).first
        if row.nil?
          raise ObjectNotFoundException.new(Gradebook, id)
        end

        version = row[:version].to_i
        site = Site.find(row[:gradebook_uid])
        name = row[:name]
        @@cache[id] = Gradebook.new(id, version, site, name)
        @@cache_by_site_id[site.id] = @@cache[id]
      end
      @@cache[id]
    end

    def self.find_by_site_id(site_id)
      if @@cache_by_site_id[site_id].nil?
        row = DB.connect.fetch("select id, version, name " +
                               "from gb_gradebook_t " +
                               "where gradebook_uid = ?", site_id).first
        if row.nil?
          raise ObjectNotFoundException.new(Gradebook, site_id)
        end

        id = row[:id].to_i
        version = row[:version].to_i
        name = row[:name]
        site = Site.find(site_id)
        @@cache[id] = Gradebook.new(id, version, site, name)
        @@cache_by_site_id[site_id] = @@cache[id]
      end
      @@cache_by_site_id[site_id]
    end

    def items
      @items ||= GradableObject.find_by_gradebook_id(@id)
    end

    def item_count
      items.length
    end
  end

  class GradableObject < SakaiObject
    attr_reader :id, :gradebook, :object_type, :version, :name
    attr_reader :points_possible, :due_date, :weight

    def initialize(id, gradebook, object_type, version, name,
                   points_possible, due_date, weight)
      @id = id
      @gradebook = gradebook
      @object_type = object_type
      @version = version
      @name = name
      @points_possible = points_possible
      @due_date = due_date
      @weight = weight
    end

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect.fetch("select gradebook_id, object_type_id, version, " +
                               "name, points_possible, " +
                               "to_char(due_date, 'YYYY-MM-DD') as due, " +
                               "assignment_weighting " +
                               "from gb_gradable_object_t " +
                               "where id = ?", id).first

        if row.nil?
          raise ObjectNotFoundException.new(GradableObject, id)
        end

        gradebook = Gradebook.find(row[:gradebook_id].to_i)
        object_type = row[:object_type_id].to_i
        version = row[:version].to_i
        name = row[:name]
        points_possible = row[:points_possible].to_f
        due_date = row[:due]
        weight = row[:assignment_weighting].to_f
        @@cache[id] = GradableObject.new(id, gradebook, object_type,
                                         version, name, points_possible,
                                         due_date, weight)
      end
      @@cache[id]
    end

    @@cache_by_gradebook_id = {}
    def self.find_by_gradebook_id(gradebook_id)
      if @@cache_by_gradebook_id[gradebook_id].nil?
        objects = []
        gradebook = Gradebook.find(gradebook_id)
        DB.connect.fetch("select id, object_type_id, version, " +
                         "name, points_possible, " +
                         "to_char(due_date, 'YYYY-MM-DD') as due, " +
                         "assignment_weighting " +
                         "from gb_gradable_object_t " +
                         "where gradebook_id = ? " +
                         "order by due_date asc", gradebook_id) do |row|
          id = row[:id].to_i
          object_type = row[:object_type_id].to_i
          version = row[:version].to_i
          name = row[:name]
          points_possible = row[:points_possible].to_f
          due_date = row[:due]
          weight = row[:assignment_weighting].to_f
          objects << GradableObject.new(id, gradebook, object_type,
                                        version, name, points_possible,
                                        due_date, weight)

        end
        @@cache_by_gradebook_id[gradebook_id] = objects
      end
      @@cache_by_gradebook_id[gradebook_id]
    end

    def default_serialization
      result = {
        "id" => self.id,
        "name" => self.name,
        "gradebook_id" => self.gradebook.id,
        "object_type" => self.object_type,
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

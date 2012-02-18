# sakai-info/gradebook.rb
#   SakaiInfo::Gradebook library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-17 daveadams@gmail.com
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
        version = site = name = nil
        DB.connect.exec("select version, gradebook_uid, name " +
                        "from gb_gradebook_t " +
                        "where id = :id", id) do |row|
          version = row[0].to_i
          site = Site.find(row[1])
          name = row[2]
        end
        if version.nil?
          raise ObjectNotFoundException.new(Gradebook, id)
        end
        @@cache[id] = Gradebook.new(id, version, site, name)
        @@cache_by_site_id[site.id] = @@cache[id]
      end
      @@cache[id]
    end

    def self.find_by_site_id(site_id)
      if @@cache_by_site_id[site_id].nil?
        id = version = site = name = nil
        DB.connect.exec("select id, version, name " +
                        "from gb_gradebook_t " +
                        "where gradebook_uid = :site_id", site_id) do |row|
          id = row[0].to_i
          version = row[1].to_i
          name = row[2]
          site = Site.find(site_id)
        end
        if version.nil?
          raise ObjectNotFoundException.new(Gradebook, site_id)
        end
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
        gradebook = object_type = version = name = points_possible = due_date = weight = nil
        DB.connect.exec("select gradebook_id, object_type_id, version, " +
                        "name, points_possible, " +
                        "to_char(due_date, 'YYYY-MM-DD'), " +
                        "assignment_weighting " +
                        "from gb_gradable_object_t " +
                        "where id = :id", id) do |row|
          gradebook = Gradebook.find(row[0].to_i)
          object_type = row[1].to_i
          version = row[2].to_i
          name = row[3]
          points_possible = row[4].to_f
          due_date = row[5]
          weight = row[6].to_f
        end
        if version.nil?
          raise ObjectNotFoundException.new(GradableObject, id)
        end
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
        DB.connect.exec("select id, object_type_id, version, " +
                        "name, points_possible, " +
                        "to_char(due_date, 'YYYY-MM-DD'), " +
                        "assignment_weighting " +
                        "from gb_gradable_object_t " +
                        "where gradebook_id = :gradebook_id " +
                        "order by due_date asc", gradebook_id) do |row|
          id = row[0].to_i
          object_type = row[1].to_i
          version = row[2].to_i
          name = row[3]
          points_possible = row[4].to_f
          due_date = row[5]
          weight = row[6].to_f
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

  # TODO: move injected method for Gradebook into Site
  # inject gradebook getter into Site class
  class Site
    def gradebook
      @gradebook ||= Gradebook.find_by_site_id(@id)
    rescue ObjectNotFoundException
      nil
    end
  end
end

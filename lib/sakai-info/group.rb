# sakai-info/group.rb
#   SakaiInfo::Group library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-24 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Group < SakaiObject
    attr_reader :site, :title

    def initialize(id, site, title)
      @id = id
      if site.is_a? Site
        @site = site
      else
        # assume the string version is a site_id
        @site = Site.find(site.to_s)
      end
      @title = title
    end

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        site_id = title = nil
        DB.connect.exec("select site_id, title from sakai_site_group " +
                        "where group_id = :id", id) do |row|
          site_id = row[0]
          title = row[1]
          @@cache[id] = Group.new(id, site_id, title)
        end
        if site_id.nil? or name.nil?
          raise ObjectNotFoundException.new(Group, id)
        end
      end
      @@cache[id]
    end

    @@cache_by_site_id = {}
    def self.find_by_site_id(site_id)
      if @@cache_by_site_id[site_id].nil?
        @@cache_by_site_id[site_id] = []
        site = Site.find(site_id)
        DB.connect.exec("select group_id, title " +
                        "from sakai_site_group " +
                        "where site_id = :site_id", site_id) do |row|
          id = row[0]
          title = row[1]
          @@cache[id] = Group.new(id, site, title)
          @@cache_by_site_id[site_id] << @@cache[id]
        end
      end
      @@cache_by_site_id[site_id]
    end

    def self.count_by_site_id(site_id)
      DB.connect[:sakai_site_group].filter(:site_id => site_id).count
    end

    def properties
      @properties ||= GroupProperty.find_by_group_id(@id)
    end

    def realm
      @authz_realm ||= AuthzRealm.find_by_site_id_and_group_id(@site.id, @id)
    end

    # serialization
    def default_serialization
      result = {
        "id" => self.id,
        "title" => self.title,
        "site_id" => self.site.id,
        "members" => self.realm.user_count,
        "properties" => self.properties
      }
      if result["properties"] == {}
        result.delete("properties")
      end
      result
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "members" => self.realm.user_count
      }
    end
  end

  class GroupProperty
    attr_reader :name, :value

    def initialize(name, value)
      @name = name
      @value = value
    end

    def self.find_by_group_id(group_id)
      properties = []
      DB.connect.exec("select name, value from sakai_site_group_property " +
                      "where group_id=:group_id", group_id) do |row|
        properties << GroupProperty.new(row[0], row[1].read)
      end
      properties
    end
  end
end

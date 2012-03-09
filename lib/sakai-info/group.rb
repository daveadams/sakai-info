# sakai-info/group.rb
#   SakaiInfo::Group library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-03-09 daveadams@gmail.com
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
        row = DB.connect[:sakai_site_group].filter(:group_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(Group, id)
        end
        @@cache[id] = Group.new(id, row[:site_id], row[:title])
      end
      @@cache[id]
    end

    @@cache_by_site_id = {}
    def self.find_by_site_id(site_id)
      if @@cache_by_site_id[site_id].nil?
        @@cache_by_site_id[site_id] = []
        site = Site.find(site_id)

        DB.connect[:sakai_site_group].filter(:site_id => site_id).all.each do |row|
          @@cache[row[:group_id]] = Group.new(row[:group_id], site, row[:title])
          @@cache_by_site_id[site_id] << @@cache[row[:group_id]]
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
    def self.get(group_id, property_name)
      row = DB.connect[:sakai_site_group_property].
        filter(:group_id => group_id, :name => property_name).first
      if row.nil?
        nil
      else
        row[:value].read
      end
    end

    def self.find_by_group_id(group_id)
      properties = {}
      # HACK: reading blobs via OCI8 is really slow, make the db server do it!
      #  This is multiple orders of magnitude faster.
      #  But, this will break if the property value is > 4000chars and may not work
      #  on mysql, so here's the original version:
      # DB.connect[:sakai_site_group_property].where(:group_id => group_id).all.each do |row|
      #   properties[row[:name]] = row[:value].read
      # end
      DB.connect[:sakai_site_group_property].
        select(:name, :to_char.sql_function(:value).as(:value)).
        where(:group_id => group_id).all.each do |row|
        properties[row[:name]] = row[:value]
      end
      return properties
    end
  end
end

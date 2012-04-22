# sakai-info/group.rb
#   SakaiInfo::Group library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-04-22 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Group < SakaiObject
    attr_reader :site_id, :title, :dbrow

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:group_id]
      @site_id = dbrow[:site_id]
      @title = dbrow[:title]
    end

    def site
      @site ||= Site.find(@site_id)
    end

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:sakai_site_group].filter(:group_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(Group, id)
        end
        @@cache[id] = Group.new(row)
      end
      @@cache[id]
    end

    def self.query_by_site_id(site_id)
      DB.connect[:sakai_site_group].where(:site_id => site_id)
    end

    def self.find_by_site_id(site_id)
      Group.query_by_site_id(site_id).all.
        collect { |row| @@cache[row[:group_id]] = Group.new(row) }
    end

    def self.count_by_site_id(site_id)
      Group.query_by_site_id(site_id).count
    end

    def properties
      @properties ||= GroupProperty.find_by_group_id(self.id)
    end

    def realm
      @authz_realm ||= AuthzRealm.find_by_site_id_and_group_id(self.site_id, self.id)
    end

    def providers
      @providers ||= self.realm.providers
    end

    def users
      @users ||= AuthzRealmMembership.find_by_realm_id(self.realm.id).collect{|arm|arm.user}
    end

    # serialization
    def default_serialization
      result = {
        "id" => self.id,
        "title" => self.title,
        "site" => self.site.serialize(:summary),
        "user_count" => self.realm.user_count,
        "providers" => self.providers,
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
        "user_count" => self.realm.user_count
      }
    end

    def users_serialization
      {
        "users" => self.users.collect { |u| u.serialize(:summary) }
      }
    end

    def realm_serialization
      {
        "realm" => self.realm.name
      }
    end

    def self.all_serializations
      [:default, :users, :realm]
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
      DB.connect[:sakai_site_group_property].
        where(:group_id => group_id).all.each do |row|
        properties[row[:name]] = row[:value].read
      end
      return properties
    end
  end
end

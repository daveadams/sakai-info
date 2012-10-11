# sakai-info/alias.rb
#   SakaiInfo::Alias library
#
# Created 2012-10-11 daveadams@gmail.com
# Last updated 2012-10-11 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Alias < SakaiObject
    attr_reader :target, :dbrow

    include ModProps
    created_by_key :createdby
    created_at_key :createdon
    modified_by_key :modifiedby
    modified_at_key :modifiedon

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:alias_id]
      @target = dbrow[:target]
    end

    # target types
    #   /mailarchive/channel/<site-id>/main
    #   /site/<site-id>
    #   /announcement/announcement/<site-id> -> rss feed
    def site_id
      if @target.nil?
        nil
      else
        if @target =~ /^\/site\/(.+)$/
          $1
        elsif @target =~ /^\/mailarchive\/channel\/(.+)\/main$/
          $1
        elsif @target =~ /^\/announcement\/announcement\/(.+)$/
          $1
        else
          nil
        end
      end
    end

    def site
      if not self.site_id.nil?
        @site ||= Site.find(self.site_id)
      end
    end

    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:sakai_alias].filter(:alias_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(Alias, id)
        end
        @@cache[id] = Alias.new(row)
      end
      @@cache[id]
    end

    def self.query_by_site_id(site_id)
      DB.connect[:sakai_alias].where("target like ?", "%#{site_id}%")
    end

    def self.find_by_site_id(site_id)
      Alias.query_by_site_id(site_id).all.
        collect { |row| @@cache[row[:alias_id]] = Alias.new(row) }
    end

    def self.count_by_site_id(site_id)
      Alias.query_by_site_id(site_id).count
    end

    def properties
      @properties ||= AliasProperty.find_by_alias_id(self.id)
    end

    # serialization
    def default_serialization
      result = {
        "id" => self.id,
        "target" => self.target,
        "site" => nil,
        "properties" => self.properties,
      }
      if not self.site.nil?
        result["site"] = self.site.serialize(:summary)
      else
        result.delete("site")
      end
      result
    end

    def summary_serialization
      {
        "id" => self.id,
        "target" => self.target,
      }
    end

    def self.all_serializations
      [:default, :mod]
    end
  end

  class AliasProperty
    def self.get(id, property_name)
      row = DB.connect[:sakai_alias_property].
        filter(:alias_id => id, :name => property_name).first
      if row.nil?
        nil
      else
        row[:value].read
      end
    end

    def self.find_by_alias_id(id)
      properties = {}
      DB.connect[:sakai_alias_property].
        where(:alias_id => id).all.each do |row|
        properties[row[:name]] = row[:value].read
      end
      return properties
    end
  end
end

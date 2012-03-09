# sakai-info/page.rb
#   SakaiInfo::Page library
#
# Created 2012-03-08 daveadams@gmail.com
# Last updated 2012-03-09 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Page < SakaiObject
    attr_reader :title, :order, :layout, :site_id, :dbrow

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:sakai_site_page].where(:page_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(Page, id)
        end

        @@cache[id] = Page.new(row)
      end
      @@cache[id]
    end

    def self.query_by_site_id(site_id)
      DB.connect[:sakai_site_page].where(:site_id => site_id)
    end

    def self.count_by_site_id(site_id)
      Page.query_by_site_id(site_id).count
    end

    def self.find_by_site_id(site_id)
      Page.query_by_site_id(site_id).order(:site_order).all.
        collect { |row| @@cache[row[:page_id]] = Page.new(row) }
    end

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:page_id]
      @title = dbrow[:title]
      @order = dbrow[:site_order].to_i
      @layout = dbrow[:layout]
      @site_id = dbrow[:site_id]
    end

    def site
      @site ||= Site.find(@site_id)
    end

    def properties
      @properties ||= PageProperty.find_by_page_id(@id)
    end

    def tools
      @tools ||= Tool.find_by_page_id(@id)
    end

    # serialization
    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "site_id" => self.site_id
      }
    end

    def site_summary_serialization
      result = summary_serialization
      result.delete("site_id")
      result["order"] = self.order
      result["tools"] = self.tools.collect { |tool| tool.serialize(:summary) }
      if not self.properties.nil? and self.properties != {}
        result["properties"] = self.properties
      end
      result
    end

    def default_serialization
      result = site_summary_serialization
      result["site"] = self.site.serialize(:summary)
      result
    end
  end

  class PageProperty
    def self.get(page_id, property_name)
      row = DB.connect[:sakai_site_page_property].
        filter(:page_id => page_id, :name => property_name).first
      if row.nil?
        nil
      else
        row[:value].read
      end
    end

    def self.find_by_page_id(page_id)
      properties = {}
      # HACK: reading blobs via OCI8 is really slow, make the db server do it!
      #  This is multiple orders of magnitude faster.
      #  But, this will break if the property value is > 4000chars and may not work
      #  on mysql, so here's the original version:
      # DB.connect[:sakai_site_page_property].where(:page_id => page_id).all.each do |row|
      #   properties[row[:name]] = row[:value].read
      # end
      DB.connect[:sakai_site_page_property].
        select(:name, :to_char.sql_function(:value).as(:value)).
        where(:page_id => page_id).all.each do |row|
        properties[row[:name]] = row[:value]
      end
      return properties
    end
  end
end


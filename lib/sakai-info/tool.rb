# sakai-info/tool.rb
#   SakaiInfo::Tool library
#
# Created 2012-03-08 daveadams@gmail.com
# Last updated 2012-04-22 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Tool < SakaiObject
    attr_reader :title, :registration, :order, :layout, :page_id, :site_id, :dbrow

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:sakai_site_tool].where(:tool_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(Tool, id)
        end

        @@cache[id] = Tool.new(row)
      end
      @@cache[id]
    end

    def self.query_by_page_id(page_id)
      DB.connect[:sakai_site_tool].where(:page_id => page_id)
    end

    def self.count_by_page_id(page_id)
      Tool.query_by_page_id(page_id).count
    end

    def self.find_by_page_id(page_id)
      Tool.query_by_page_id(page_id).order(:page_order).all.
        collect { |row| @@cache[row[:tool_id]] = Tool.new(row) }
    end

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:tool_id]
      @title = dbrow[:title]
      @registration = dbrow[:registration]
      @order = dbrow[:page_order].to_i
      @layout = dbrow[:layout_hints]
      @page_id = dbrow[:page_id]
      @site_id = dbrow[:site_id]
    end

    def page
      @page ||= Page.find(@page_id)
    end

    def site
      @site ||= Site.find(@site_id)
    end

    def properties
      @properties ||= ToolProperty.find_by_tool_id(@id)
    end

    # serialization
    def default_serialization
      result = {
        "id" => self.id,
        "registration" => self.registration,
        "title" => self.title,
        "site" => self.site.serialize(:summary),
        "page_id" => self.page_id,
        "order" => self.order,
        "layout" => self.layout,
        "properties" => self.properties
      }
      if result["properties"] == {}
        result.delete("properties")
      end
      if result["layout"].nil?
        result.delete("layout")
      end
      result
    end

    def summary_serialization
      {
        "id" => self.id,
        "registration" => self.registration,
        "title" => self.title
      }
    end
  end

  class ToolProperty
    def self.get(tool_id, property_name)
      row = DB.connect[:sakai_site_tool_property].
        filter(:tool_id => tool_id, :name => property_name).first
      if row.nil?
        nil
      else
        row[:value].read
      end
    end

    def self.find_by_tool_id(tool_id)
      properties = {}
      DB.connect[:sakai_site_tool_property].
        where(:tool_id => tool_id).all.each do |row|
        properties[row[:name]] = row[:value].read
      end
      return properties
    end
  end
end


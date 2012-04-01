# sakai-info/forum.rb
#   SakaiInfo::Forum library
#
# Created 2012-04-01 daveadams@gmail.com
# Last updated 2012-04-01 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Forum < SakaiObject
    attr_reader :id, :title, :dbrow

    include ModProps
    created_by_key :created_by
    created_at_key :created
    modified_by_key :modified_by
    modified_at_key :modified

    @@cache = {}
    def self.find(id)
      if @@cache[id.to_s].nil?
        row = DB.connect[:mfr_open_forum_t].filter(:id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(Forum, id)
        end
        @@cache[id.to_s] = Forum.new(row)
      end
      @@cache[id.to_s]
    end

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:id].to_i
      @title = dbrow[:title]
      @area_id = dbrow[:surrogatekey]

      @site_id_is_nil = false
    end

    def site_id
      return nil if @site_id_is_nil

      if @site_id.nil?
        result = DB.connect[:mfr_area_t].
          select(:context_id).where(:id => @area_id).first
        if result.nil?
          @site_id_is_nil = true
          return nil
        else
          @site_id = result[:context_id]
        end
      end
      @site_id
    end

    def site
      if self.site_id.nil?
        return nil
      end

      @site ||= Site.find(self.site_id)
    end

    def self.query_by_site_id(site_id)
      db = DB.connect
      db[:mfr_open_forum_t].
        where(:surrogatekey =>
              db[:mfr_area_t].select(:id).where(:context_id => site_id)).
        where(:forum_dtype => "DF")
    end

    def self.count_by_site_id(site_id)
      Forum.query_by_site_id(site_id).count
    end

    def self.find_by_site_id(site_id)
      Forum.query_by_site_id(site_id).all.
        collect { |row| @@cache[row[:id].to_i.to_s] = Forum.new(row) }
    end

    def default_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "site" => self.site.serialize(:summary)
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title
      }
    end
  end

  class ForumTopic < SakaiObject
  end

  class ForumPost < GenericMessage
  end
end


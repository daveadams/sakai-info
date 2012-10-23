# sakai-info/wiki.rb
#   SakaiInfo::Wiki library
#
# Created 2012-10-23 daveadams@gmail.com
# Last updated 2012-10-23 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class WikiPage < SakaiObject
    attr_reader :dbrow

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:id]
    end

    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:rwikiobject].filter(:id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(WikiPage, id)
        end
        @@cache[id] = WikiPage.new(row)
      end
      @@cache[id]
    end

    def owner
      @owner ||= User.find(@dbrow[:owner])
    end

    def name
      @dbrow[:name]
    end

    # serialization
    def default_serialization
      result = {
        "id" => self.id,
        "name" => self.name,
        "owner" => self.owner.serialize(:summary),
      }
      result
    end

    def summary_serialization
      {
        "id" => self.id,
        "name" => self.name,
        "owner" => self.owner.eid,
      }
    end

    def self.all_serializations
      [
       :default,
      ]
    end
  end
end

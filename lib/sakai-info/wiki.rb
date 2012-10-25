# sakai-info/wiki.rb
#   SakaiInfo::Wiki library
#
# Created 2012-10-23 daveadams@gmail.com
# Last updated 2012-10-25 daveadams@gmail.com
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
      @owner ||= User.find!(@dbrow[:owner])
    end

    def realm
      if not self.realm_name.nil?
        @realm ||= AuthzRealm.find!(self.realm_name)
      end
    end

    def realm_name
      @dbrow[:realm]
    end

    def site_id
      @site_id ||= if not self.realm_name.nil?
                     if self.realm_name =~ /^\/site\/([^\/]+)/
                       $1
                     else
                       nil
                     end
                   else
                     nil
                   end
    end

    def site
      @site ||= if not self.site_id.nil?
                  Site.find!(self.site_id)
                else
                  nil
                end
    end

    def page_name
      @page_name ||= if not self.realm_name.nil?
                       if @dbrow[:name] =~ /^#{self.realm_name}\/(.+)$/
                         $1
                       else
                         @dbrow[:name]
                       end
                     end
    end

    # serialization
    def default_serialization
      result = {
        "id" => self.id,
        "page_name" => self.page_name,
        "realm" => self.realm.serialize(:summary),
        "owner" => self.owner.serialize(:summary),
        "site" => self.site.serialize(:summary),
      }
      result
    end

    def summary_serialization
      {
        "id" => self.id,
        "name" => self.name,
        "owner" => self.owner.eid,
        "site_id" => self.site_id,
      }
    end

    def self.all_serializations
      [
       :default,
      ]
    end
  end
end

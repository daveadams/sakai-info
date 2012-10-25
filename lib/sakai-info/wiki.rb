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

    def last_updated
      @dbrow[:version]
    end

    def revision
      @dbrow[:revision]
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

    def owner_readable?
      @dbrow[:ownerread] == 1
    end

    def owner_writable?
      @dbrow[:ownerwrite] == 1
    end

    def owner_admin?
      @dbrow[:owneradmin] == 1
    end

    def group_readable?
      @dbrow[:groupread] == 1
    end

    def group_writable?
      @dbrow[:groupwrite] == 1
    end

    def group_admin?
      @dbrow[:groupadmin] == 1
    end

    def public_readable?
      @dbrow[:publicread] == 1
    end

    def public_writable?
      @dbrow[:publicwrite] == 1
    end

    def permission_string
      (self.owner_readable? ? "r" : "-") +
        (self.owner_writable? ? "w" : "-") +
        (self.owner_admin? ? "A" : "-") +
        (self.group_readable? ? "r" : "-") +
        (self.group_writable? ? "w" : "-") +
        (self.group_admin? ? "A" : "-") +
        (self.public_readable? ? "r" : "-") +
        (self.public_writable? ? "w" : "-") +
        "-"
    end

    def content
      @content ||= DB.connect[:rwikicurrentcontent].where(:rwikiid => self.id).first[:content].read
    end

    # serialization
    def default_serialization
      result = {
        "id" => self.id,
        "page_name" => self.page_name,
        "last_updated" => self.last_updated,
        "realm" => self.realm.serialize(:summary),
        "owner" => self.owner.serialize(:summary),
        "site" => self.site.serialize(:summary),
        "permissions" => self.permission_string,
        "revision" => self.revision,
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

    def permissions_serialization
      {
        "permissions" => {
          "owner" => {
            "read" => self.owner_readable?,
            "write" => self.owner_writable?,
            "admin" => self.owner_admin?,
          },
          "group" => {
            "read" => self.group_readable?,
            "write" => self.group_writable?,
            "admin" => self.group_admin?,
          },
          "public" => {
            "read" => self.public_readable?,
            "write" => self.public_writable?,
          }
        }
      }
    end

    def content_serialization
      {
        "content" => self.content,
      }
    end

    def self.all_serializations
      [
       :default,
       :permissions,
       :content,
      ]
    end
  end
end

# sakai-info/mod_props.rb
#   SakaiInfo::ModProps library
#
# Created 2012-02-26 daveadams@gmail.com
# Last updated 2012-02-26 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  module ModProps
    def self.included(klass)
      klass.module_eval {
        @@mod_props_keys = {
          :created_at => :createdon,
          :created_by => :createdby,
          :modified_at => :modifiedon,
          :modified_by => :modifiedby
        }

        def self.created_at_key(newkey)
          @@mod_props_keys[:created_at] = newkey
        end

        def self.created_by_key(newkey)
          @@mod_props_keys[:created_by] = newkey
        end

        def self.modified_at_key(newkey)
          @@mod_props_keys[:modified_at] = newkey
        end

        def self.modified_by_key(newkey)
          @@mod_props_keys[:modified_by] = newkey
        end

        def created_by_id
          self.dbrow[@@mod_props_keys[:created_by]]
        end

        def created_by
          @created_by ||= User.find(@dbrow[@@mod_props_keys[:created_by]])
        end

        def created_at
          @dbrow[@@mod_props_keys[:created_at]]
        end

        def modified_by
          @modified_by ||= User.find(@dbrow[@@mod_props_keys[:modified_by]])
        end

        def modified_by_id
          @dbrow[@@mod_props_keys[:modified_by]]
        end

        def modified_at
          @dbrow[@@mod_props_keys[:modified_at]]
        end

        def mod_serialization
          {
            "created_by" => self.created_by.serialize(:summary),
            "created_at" => self.created_at.strftime("%Y-%m-%d %H:%M:%S"),
            "modified_by" => self.modified_by.serialize(:summary),
            "modified_at" => self.modified_at.strftime("%Y-%m-%d %H:%M:%S")
          }
        end
      }
    end
  end
end

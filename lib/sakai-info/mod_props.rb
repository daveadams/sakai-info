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
      klass.class_eval {
        # defaults based on User and Site objects
        def get_created_at_key; :createdon; end
        def get_created_by_key; :createdby; end
        def get_modified_at_key; :modifiedon; end
        def get_modified_by_key; :modifiedby; end

        def self.created_at_key(newkey)
          self.class_eval("def get_created_at_key; :#{newkey}; end")
        end

        def self.created_by_key(newkey)
          self.class_eval("def get_created_by_key; :#{newkey}; end")
        end

        def self.modified_at_key(newkey)
          self.class_eval("def get_modified_at_key; :#{newkey}; end")
        end

        def self.modified_by_key(newkey)
          self.class_eval("def get_modified_by_key; :#{newkey}; end")
        end

        def created_by_id
          @dbrow[self.get_created_by_key]
        end

        def created_by
          User.find(self.created_by_id)
        end

        def created_at
          @dbrow[self.get_created_at_key]
        end

        def modified_by_id
          @dbrow[self.get_modified_by_key]
        end

        def modified_by
          User.find(self.modified_by_id)
        end

        def modified_at
          @dbrow[self.get_modified_at_key]
        end

        def mod_serialization
          {
            "created_at" => self.created_at,
            "created_by" => User.get_eid(self.created_by_id),
            "modified_at" => self.modified_at,
            "modified_by" => User.get_eid(self.modified_by_id),
          }
        end

        def mod_details_serialization
          {
            "created_at" => self.created_at,
            "created_by" => self.created_by.serialize(:summary),
            "modified_at" => self.modified_at,
            "modified_by" => self.modified_by.serialize(:summary),
          }
        end
      }
    end
  end
end

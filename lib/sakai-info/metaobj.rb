# sakai-info/metaobj.rb
#   SakaiInfo::Metaobj library (OSP form support)
#
# Created 2012-10-15 daveadams@gmail.com
# Last updated 2012-10-23 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Metaobj < SakaiObject
    attr_reader :dbrow, :description, :external_type, :schema_hash

    include ModProps
    created_by_key :owner
    created_at_key :created
    modified_by_key :owner
    modified_at_key :modified

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:id]
      @description = dbrow[:description]
      @external_type = dbrow[:externaltype]
    end

    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:metaobj_form_def].filter(:id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(Metaobj, id)
        end
        @@cache[id] = Metaobj.new(row)
      end
      @@cache[id]
    end

    def owner
      @owner ||= User.find(@dbrow[:owner])
    end

    def system_only?
      @dbrow[:systemonly] == 1
    end

    def site
      if @dbrow[:siteid]
        begin
          @site ||= Site.find(@dbrow[:siteid])
        rescue ObjectNotFoundException
          nil
        end
      else
        nil
      end
    end

    def site_state
      case @dbrow[:sitestate]
      when 0
        "unpublished"
      when 2
        "published"
      else
        @dbrow[:sitestate]
      end
    end

    def published?
      self.site_state == "published"
    end

    def global_state
      case @dbrow[:globalstate]
      when 0
        "unpublished"
      when 1
        "pending approval"
      when 2
        "published"
      else
        @dbrow[:globalstate]
      end
    end

    def globally_published?
      self.global_state == "published"
    end

    def pending_approval?
      self.global_state == "pending approval"
    end

    def alternate_create_xslt
      if @dbrow[:alternatecreatexslt].nil?
        nil
      else
        @@alternate_create_xslt ||= ContentResource.find_by_uuid(@dbrow[:alternatecreatexslt])
      end
    end

    def alternate_view_xslt
      if @dbrow[:alternateviewxslt].nil?
        nil
      else
        @@alternate_view_xslt ||= ContentResource.find_by_uuid(@dbrow[:alternateviewxslt])
      end
    end

    def instructions
      if @dbrow[:instructions].nil?
        nil
      else
        @instructions ||= @dbrow[:instruction].read
      end
    end

    def schemadata
      @schemadata ||= @dbrow[:schemadata].read.force_encoding(Encoding::UTF_8)
    end

    # serialization
    def default_serialization
      return { "schemadata" => self.schemadata }

      result = {
        "id" => self.id,
        "description" => self.description,
        "owner" => self.owner.serialize(:summary),
        "site" => nil,
        "system_only" => self.system_only?,
        "published" => self.published?,
        "globally_published" => self.globally_published?,
        "pending_approval" => self.pending_approval?,
        "external_type" => self.external_type,
        "alternate_create_xslt" => nil,
        "alternate_view_xslt" => nil,
        "schema_hash" => self.schema_hash,
      }
      if self.site.nil?
        result.delete("site")
      else
        result["site"] = self.site.serialize(:summary)
      end
      if not self.pending_approval?
        result.delete("pending_approval")
      end
      if self.alternate_create_xslt.nil?
        result.delete("alternate_create_xslt")
      else
        result["alternate_create_xslt"] = self.alternate_create_xslt.serialize(:summary)
      end
      if self.alternate_view_xslt.nil?
        result.delete("alternate_view_xslt")
      else
        result["alternate_view_xslt"] = self.alternate_view_xslt.serialize(:summary)
      end
      result
    end

    def summary_serialization
      {
        "id" => self.id,
        "description" => self.description,
        "owner" => self.owner.eid,
      }
    end

    def instructions_serialization
      {
        "instructions" => self.instructions,
      }
    end

    def schemadata_serialization
      {
        "schemadata" => self.schemadata,
      }
    end

    def self.all_serializations
      [
       :default,
       :mod,
       :instructions,
       :schemadata,
      ]
    end
  end
end

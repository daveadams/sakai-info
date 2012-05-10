# sakai-info/content.rb
#   SakaiInfo::Content library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-05-10 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Content < SakaiObject
    attr_reader :parent_id

    include ModProps
    created_by_key :_binary_entity_created_by
    created_at_key :_binary_entity_created_at
    modified_by_key :_binary_entity_modified_by
    modified_at_key :_binary_entity_modified_at

    def self.find(id)
      begin
        ContentResource.find(id)
      rescue ObjectNotFoundException
        begin
          ContentCollection.find(id)
        rescue ObjectNotFoundException
          if not id.match(/\/$/)
            ContentCollection.find(id + "/")
          else
            raise ObjectNotFoundException.new(Content, id)
          end
        end
      end
    end

    def parent
      if @parent_id.nil?
        nil
      else
        @parent ||= ContentCollection.find(@parent_id)
      end
    end

    def size_on_disk
      0
    end

    def binary_entity
      if @binary_entity.nil?
        @binary_entity = ContentBinaryEntity.new(@dbrow[:binary_entity])

        @dbrow[:_binary_entity_created_by] = @binary_entity["CHEF:creator"]
        @dbrow[:_binary_entity_modified_by] = @binary_entity["CHEF:modifiedby"]
        @dbrow[:_binary_entity_created_at] =
          Util.format_entity_date(@binary_entity["DAV:creationdate"])
        @dbrow[:_binary_entity_modified_at] =
          Util.format_entity_date(@binary_entity["DAV:getlastmodified"])
      end

      @binary_entity
    end

    def default_serialization
      {
        "id" => self.id,
        "parent" => self.parent_id,
        "size_on_disk" => self.size_on_disk
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "parent" => self.parent_id,
        "size_on_disk" => self.size_on_disk
      }
    end

    def realm
      if @realm_is_nil
        nil
      else
        begin
          @realm ||= AuthzRealm.find_by_name("/content#{@id}")
        rescue ObjectNotFoundException
          @realm_is_nil = true
          nil
        end
      end
    end

    def effective_realm
      self.realm || (parent.nil? ? nil : parent.effective_realm)
    end

    def realm_serialization
      if self.effective_realm.nil?
        {}
      else
        {
          "effective_realm" => self.effective_realm.name,
        }
      end
    end

    def child_summary_serialization
      {
        "id" => self.id.gsub(/^#{self.parent_id}/,""),
        "size" => self.size_on_disk,
      }
    end

    def properties_serialization
      result = self.binary_entity.to_hash
      if result["groups"] == []
        result.delete("groups")
      end
      result.keys.each do |key|
        if result[key].nil? or result[key] == ""
          result.delete(key)
        end
      end
      {
        "properties" => result
      }
    end

    # ensure @binary_entity has been parsed before returning mod info
    alias :original_mod_serialization :mod_serialization
    alias :original_mod_details_serialization :mod_details_serialization

    def mod_serialization
      self.binary_entity
      self.original_mod_serialization
    end

    def mod_details_serialization
      self.binary_entity
      self.original_mod_details_serialization
    end
  end

  class ContentResource < Content
    attr_reader :file_path, :uuid, :context, :resource_type_id, :dbrow

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(dbrow)
      @dbrow = dbrow

      @id = @dbrow[:resource_id]
      @parent_id = @dbrow[:in_collection]
      @file_path = @dbrow[:file_path]
      @uuid = @dbrow[:resource_uuid]
      @file_size = @dbrow[:file_size].to_i
      @context = @dbrow[:context]
      @resource_type_id = @dbrow[:resource_type_id]

      @table_name = "content_resource"
      @id_column = "resource_id"
    end

    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:content_resource].where(:resource_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(ContentResource, id)
        end
        @@cache[id] = ContentResource.new(row)
      end
      @@cache[id]
    end

    def size_on_disk
      @file_size
    end

    def self.query_by_parent(parent_id)
      DB.connect[:content_resource].where(:in_collection => parent_id)
    end

    def self.find_by_parent(parent_id)
      resources = []
      ContentResource.query_by_parent(parent_id).all.each do |row|
        @@cache[row[:resource_id]] = ContentResource.new(row)
        resources << @@cache[row[:resource_id]]
      end
      resources
    end

    def self.count_by_parent(parent_id)
      ContentResource.query_by_parent(parent_id).count
    end

    def default_serialization
      result = {
        "id" => self.id,
        "uuid" => self.uuid,
        "file_path" => self.file_path,
        "size_on_disk" => self.size_on_disk,
        "context" => self.context,
        "resource_type" => self.resource_type_id,
      }
      if result["uuid"].nil?
        result.delete("uuid")
      end
      result
    end

    def summary_serialization
      {
        "id" => self.id,
        "size" => self.size_on_disk,
      }
    end
  end

  class ContentCollection < Content
    attr_reader :dbrow

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(dbrow)
      @dbrow = dbrow

      @id = @dbrow[:collection_id]
      @parent_id = @dbrow[:in_collection]

      @table_name = "content_collection"
      @id_column = "collection_id"
    end

    def self.find(id)
      if id !~ /\/$/
        id += "/"
      end

      if @@cache[id].nil?
        row = DB.connect[:content_collection].where(:collection_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(ContentCollection, id)
        end
        @@cache[id] = ContentCollection.new(row)
      end
      @@cache[id]
    end

    # return a content collection, even if it's a missing one
    def self.find!(id)
      begin
        ContentCollection.find(id)
      rescue ObjectNotFoundException
        MissingContentCollection.find(id)
      end
    end

    def self.find_portfolio_interaction_collections
      collections = []
      DB.connect[:content_collection].
        where(:collection_id.like('%/portfolio-interaction/')) do |row|
        @@cache[row[:collection_id]] = ContentCollection.new(row)
        collections << @@cache[row[:collection_id]]
      end
      collections
    end

    def size_on_disk
      @size_on_disk ||=
        DB.connect[:content_resource].select(:sum.sql_function(:file_size).as(:total_size)).
        where(:resource_id.like("#{@id}%")).first[:total_size].to_i
    end

    def children
      @child_collections ||= ContentCollection.find_by_parent(@id)
      @child_resources ||= ContentResource.find_by_parent(@id)
      {
        "collections" => @child_collections,
        "resources" => @child_resources
      }
    end

    def child_counts
      @child_collection_count ||= if @child_collections.nil?
                                    ContentCollection.count_by_parent(@id)
                                  else
                                    @child_collections.length
                                  end
      @child_resource_count ||= if @child_resources.nil?
                                  ContentResource.count_by_parent(@id)
                                else
                                  @child_resources.length
                                end
      {
        "collections" => @child_collection_count,
        "resources" => @child_resource_count,
        "total" => @child_collection_count + @child_resource_count
      }
    end

    def default_serialization
      {
        "id" => self.id,
        "size_on_disk" => self.size_on_disk,
        "children" => self.child_counts,
      }
    end

    def summary_serialization
      {
        "id" => self.id,
      }
    end

    def children_serialization
      result = {
        "collections" => self.children["collections"].collect { |cc|
          cc.serialize(:child_summary, :children)
        },
        "resources" => self.children["resources"].collect { |cr|
          cr.serialize(:child_summary)
        }
      }
      if result["collections"] == []
        result.delete("collections")
      end
      if result["resources"] == []
        result.delete("resources")
      end
      result
    end

    def self.query_by_parent(parent_id)
      DB.connect[:content_collection].where(:in_collection => parent_id)
    end

    def self.count_by_parent(parent_id)
      ContentCollection.query_by_parent(parent_id).count
    end

    def self.find_by_parent(parent_id)
      collections = []
      ContentCollection.query_by_parent(parent_id).all.each do |row|
        @@cache[row[:collection_id]] = ContentCollection.new(row)
        collections << @@cache[row[:collection_id]]
      end
      collections
    end
  end

  class MissingContentCollection < ContentCollection
    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def self.find(id)
      @@cache[id] ||= MissingContentCollection.new(id, nil)
    end

    def size_on_disk
      0
    end
  end

  class UnknownBinaryEntityFormat < SakaiException; end
  class ContentBinaryEntity
    require 'stringio'

    def read_tiny_int(bin)
      bin.read(1).unpack("C")[0]
    end

    def read_int(bin)
      bin.read(2).unpack("n")[0]
    end

    def read_long_int(bin)
      bin.read(4).unpack("N")[0]
    end

    def read_huge_int(bin)
      part1 = bin.read(4).unpack("N")[0]
      part2 = bin.read(4).unpack("N")[0]

      return ((part1 << 32) + part2)
    end
    MAX_HUGE_INT=(2**64 - 1)

    def read_utf_string(bin)
      byte_length = read_int(bin)
      if byte_length == 0
        return ""
      end
      bin.read(byte_length).force_encoding(Encoding::UTF_8)
    end

    def initialize(raw_blob)
      blob = StringIO.new(raw_blob)
      blob_id = blob.read(6)

      serialization_type = read_long_int(blob)
      if serialization_type != 1
        raise UnknownBinaryEntityFormat.new("Unrecognized format version #{serialization_type}")
      end

      @properties = {}

      if blob_id == "CHSBRE"
        parse_for_content_resource(blob)
      elsif blob_id == "CHSBCE"
        parse_for_content_collection(blob)
      else
        raise UnknownBinaryEntityFormat.new("Unrecognized format ID: #{blob_id}")
      end
    end

    def [](key)
      @properties[key]
    end

    def keys
      @properties.keys
    end

    def to_hash
      @properties
    end

    # content resource block IDs
    # yes, block 2 = 12 and block 3 = 11
    # BLOCK1 = general attributes
    CR_BLOCK1 = 10
    # BLOCK2 = release and retract dates
    CR_BLOCK2 = 12
    # BLOCK3 = groups
    CR_BLOCK3 = 11
    # BLOCK4 = properties
    CR_BLOCK4 = 13
    # BLOCK5 = file properties
    CR_BLOCK5 = 14
    # BLOCK6 = byte[] storing file content if it's not in the filesystem
    CR_BLOCK6 = 15
    # BLOCK_END
    CR_BLOCK_END = 2

    def parse_for_content_resource(blob)
      while true
        block_number = read_long_int(blob)
        case(block_number)
        when CR_BLOCK1
          parse_block1(blob)

        when CR_BLOCK2
          parse_block2(blob)

        when CR_BLOCK3
          parse_block3(blob)

        when CR_BLOCK4
          parse_block4(blob)

        when CR_BLOCK5
          @properties["content_type"] = read_utf_string(blob)
          @properties["content_length"] = read_huge_int(blob)
          @properties["file_path"] = read_utf_string(blob)

        when CR_BLOCK6
          body_size = read_long_int(blob)
          if body_size > 0
            STDERR.puts "WARNING: files stored in the database are not currently supported"
          end

        when CR_BLOCK_END
          break

        else
          raise UnknownBinaryEntityFormat.new("Unknown Block ID: '#{block_number}'")
        end
      end
    end

    # content collection block IDs
    # BLOCK1 = general attributes
    CC_BLOCK1 = 10
    # BLOCK2 = release and retract dates
    CC_BLOCK2 = 11
    # BLOCK3 = groups
    CC_BLOCK3 = 12
    # BLOCK4 = properties
    CC_BLOCK4 = 13
    # BLOCK_END
    CC_BLOCK_END = 2

    def parse_for_content_collection(blob)
      while true
        block_number = read_long_int(blob)
        case(block_number)
        when CC_BLOCK1
          parse_block1(blob)

        when CC_BLOCK2
          parse_block2(blob)

        when CC_BLOCK3
          parse_block3(blob)

        when CC_BLOCK4
          parse_block4(blob)

        when CC_BLOCK_END
          break

        else
          raise UnknownBinaryEntityFormat.new("Unknown Block ID: '#{block_number}'")
        end
      end
    end

    def parse_block1(blob)
      @properties["id"] = read_utf_string(blob)
      @properties["resource_type"] = read_utf_string(blob)
      @properties["access_mode"] = read_utf_string(blob)
      @properties["is_hidden"] = (read_tiny_int(blob) != 0)
    end

    def parse_block2(blob)
      @properties["release_date"] = read_huge_int(blob)
      if @properties["release_date"] == MAX_HUGE_INT
        @properties["release_date"] = nil
      end

      @properties["retract_date"] = read_huge_int(blob)
      if @properties["retract_date"] == MAX_HUGE_INT
        @properties["retract_date"] = nil
      end
    end

    def parse_block3(blob)
      group_count = read_long_int(blob)
      @properties["groups"] = []
      if group_count > 0
        group_count.times do
          @properties["groups"] << read_utf_string(blob)
        end
      end
    end

    # properties block types
    PROPS_BLOCK1 = 100
    PROPS_BLOCK2 = 101
    PROPS_BLOCK3 = 102

    def parse_block4(blob)
      type = read_long_int(blob)
      if type != 1
        raise UnknownBinaryEntityFormat.new("Unknown properties serialization type #{type}")
      end

      props_block_number = read_long_int(blob)
      if props_block_number == PROPS_BLOCK1
        props_count = read_long_int(blob)
      else
        raise UnknownBinaryEntityFormat.new("Unable to parse properties block")
      end

      props_count.times do
        props_block_number = read_long_int(blob)
        case props_block_number
        when PROPS_BLOCK2
          key = read_utf_string(blob)
          value = read_utf_string(blob)
          @properties[key] = value
        when PROPS_BLOCK3
          key = read_utf_string(blob)
          @properties[key] = []
          value_count = read_long_int(blob)
          value_count.times do
            @properties[key] << read_utf_string(blob)
          end
        else
          raise UnknownBinaryEntityFormat.new("Unknown Property Block ID: '#{block_number}'")
        end
      end
    end
  end
end

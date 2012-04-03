# sakai-info/content.rb
#   SakaiInfo::Content library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-04-02 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Content < SakaiObject
    attr_reader :parent_id

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

    def binary
      if @binary.nil?
        row = DB.connect[@table_name.to_sym].filter(@id_column.to_sym => @id).first
        @binary = row[:binary_entity].read
      end
      @binary
    end

    def size_on_disk
      0
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
        rescue AuthzRealmNotFoundException
          @realm_is_nil = true
          nil
        end
      end
    end

    def effective_realm
      self.realm || (parent.nil? ? nil : parent.effective_realm)
    end
  end

  class ContentResource < Content
    attr_reader :file_path, :uuid, :context, :resource_type_id

    def initialize(id, parent_id, file_path, uuid, file_size, context, resource_type_id)
      @id = id
      @parent_id = parent_id
      @file_path = File.join(Instance.content_base_directory, file_path)
      @uuid = uuid
      @file_size = file_size
      @context = context
      @resource_type_id = resource_type_id

      @table_name = "content_resource"
      @id_column = "resource_id"
    end

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:content_resource].filter(:resource_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(ContentResource, id)
        end
        @@cache[id] = ContentResource.new(row[:resource_id], row[:in_collection], row[:file_path], row[:resource_uuid], row[:file_size].to_i, row[:context], row[:resource_type_id])
      end
      @@cache[id]
    end

    def size_on_disk
      @file_size
    end

    def default_serialization
      {
        "id" => self.id,
        "parent" => self.parent_id,
        "uuid" => self.uuid,
        "file_path" => self.file_path,
        "size_on_disk" => self.size_on_disk,
        "context" => self.context,
        "resource_type_id" => self.resource_type_id,
        "effective_realm" => (self.effective_realm.nil? ? nil : self.effective_realm.name)
      }
    end

    def self.find_by_parent(parent_id)
      resources = []
      DB.connect[:content_resource].filter(:in_collection => parent_id) do |row|
        @@cache[row[:resource_id]] =
          ContentResource.new(row[:resource_id], row[:in_collection], row[:file_path],
                                row[:resource_uuid], row[:file_size].to_i, row[:context],
                                row[:resource_type_id])
        resources << @@cache[row[0]]
      end
      resources
    end

    def self.count_by_parent(parent_id)
      DB.connect[:content_resource].filter(:in_collection => parent_id).count
    end
  end

  class ContentCollection < Content
    def initialize(id, parent_id)
      @id = id
      @parent_id = parent_id

      @table_name = "content_collection"
      @id_column = "collection_id"
    end

    @@cache = {}
    def self.find(id)
      if id !~ /\/$/
        id += "/"
      end

      if @@cache[id].nil?
        row = DB.connect[:content_collection].filter(:collection_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(ContentCollection, id)
        end
        @@cache[id] = ContentCollection.new(row[:collection_id], row[:in_collection])
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
        @@cache[row[:collection_id]] =
          ContentCollection.new(row[:collection_id], row[:in_collection])
        collections << @@cache[row[:collection_id]]
      end
      collections
    end

    def self.count_by_parent(parent_id)
      DB.connect[:content_collection].filter(:in_collection => parent_id).count
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
        "parent" => self.parent_id,
        "size_on_disk" => self.size_on_disk,
        "children" => self.child_counts,
        "effective_realm" => (self.effective_realm.nil? ? nil : effective_realm.name)
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "parent" => self.parent_id
      }
    end

    def children_serialization
      {
        "collections" => self.children["collections"].collect { |cc|
          cc.serialize(:summary, :children)
        },
        "resources" => self.children["resources"].collect { |cr|
          cr.serialize(:summary)
        }
      }
    end

    def self.find_by_parent(parent_id)
      collections = []
      DB.connect[:content_collection].filter(:in_collection => parent_id) do |row|
        @@cache[row[:collection_id]] =
          ContentCollection.new(row[:collection_id], row[:in_collection])
        collections << @@cache[row[:collection_id]]
      end
      collections
    end
  end

  class MissingContentCollection < ContentCollection
    @@cache = {}
    def self.find(id)
      @@cache[id] ||= MissingContentCollection.new(id, nil)
    end

    def size_on_disk
      0
    end
  end

  # TODO: merge binary_entity parsing code into content

  # require 'stringio'

  # def read_tiny_int(blob)
  #   blob.read(1).unpack("C")[0]
  # end

  # def read_int(blob)
  #   blob.read(2).unpack("n")[0]
  # end

  # def read_long_int(blob)
  #   blob.read(4).unpack("N")[0]
  # end

  # def read_huge_int(blob)
  #   part1 = blob.read(4).unpack("N")[0]
  #   part2 = blob.read(4).unpack("N")[0]

  #   return ((part1 << 32) + part2)
  # end
  # MAX_HUGE_INT=(2**64 - 1)

  # def read_utf_string(blob)
  #   # 'n' means big-endian 16-bit unsigned int
  #   byte_length = read_int(blob)
  #   if byte_length == 0
  #     return ""
  #   end
  #   blob.read(byte_length).force_encoding(Encoding::UTF_8)
  # end

  # ENV["NLS_LANG"] ||= "AMERICAN_AMERICA.UTF8"

  # require 'oci8'
  # db = OCI8.new("sakai", "ootfpitf", "SAKAI")

  # resource_id = ARGV[0]
  # blob = nil
  # db.exec("select binary_entity from content_resource where resource_id=:id", resource_id) do |row|
  #   blob = StringIO.new(row[0].read)
  # end

  # if blob.nil?
  #   puts "No such resource"
  #   exit 1
  # end

  # puts "Blob size: #{blob.size}"

  # blob_id = blob.read(6)
  # puts "Blob ID: #{blob_id}"

  # serialization_type = read_long_int(blob)
  # puts "Serialization type: #{serialization_type}"

  # # don't ask me why the blocks are coded this way
  # # BLOCK1 = general attributes
  # BLOCK1 = 10
  # # BLOCK2 = release and retract dates
  # BLOCK2 = 12
  # # BLOCK3 = groups
  # BLOCK3 = 11
  # # BLOCK4 = properties
  # BLOCK4 = 13
  # # BLOCK5 = file properties
  # BLOCK5 = 14
  # # BLOCK6 = byte[] storing file content if it's not in the filesystem
  # BLOCK6 = 15
  # # BLOCK_END
  # BLOCK_END = 2

  # # properties block types
  # PROPS_BLOCK1 = 100
  # PROPS_BLOCK2 = 101
  # PROPS_BLOCK3 = 102

  # while true
  #   puts
  #   puts "Starting new block"
  #   puts "Current position: #{blob.pos}"

  #   block_number = read_long_int(blob)
  #   case(block_number)
  #   when BLOCK1
  #     puts "BLOCK1"

  #     # read ID
  #     id = read_utf_string(blob)
  #     puts "Content ID: #{id}"

  #     # read resource type
  #     resource_type = read_utf_string(blob)
  #     puts "Resource Type: #{resource_type}"

  #     access_mode = read_utf_string(blob)
  #     puts "Access Mode: #{access_mode}"

  #     is_hidden = (read_tiny_int(blob) != 0)
  #     puts "Hidden?: #{is_hidden}"

  #   when BLOCK2
  #     puts "BLOCK2"

  #     releaseDate = read_huge_int(blob)
  #     if releaseDate == MAX_HUGE_INT
  #       puts "Release Date: n/a"
  #     else
  #       puts "Release Date: #{releaseDate}"
  #     end

  #     retractDate = read_huge_int(blob)
  #     if retractDate == MAX_HUGE_INT
  #       puts "Retract Date: n/a"
  #     else
  #       puts "Retract Date: #{retractDate}"
  #     end

  #   when BLOCK3
  #     puts "BLOCK3"

  #     group_count = read_long_int(blob)
  #     puts "Group count: #{group_count}"
  #     if group_count > 0
  #       puts "Groups:"
  #       groups = []
  #       group_count.times do
  #         groups << read_utf_string(blob)
  #       end
  #       groups.each do |g|
  #         puts "  - #{g}"
  #       end
  #     end

  #   when BLOCK4
  #     puts "BLOCK4"

  #     # properties
  #     props_serialization_type = read_long_int(blob)
  #     puts "Properties Serialization Type: #{props_serialization_type}"

  #     props_block_number = read_long_int(blob)
  #     if props_block_number == PROPS_BLOCK1
  #       #puts "PROPS_BLOCK1"
  #       props_count = read_long_int(blob)
  #       puts "Property Count: #{props_count}"
  #     else
  #       puts "Failed to parse Property Block"
  #       exit 1
  #     end

  #     props_count.times do
  #       props_block_number = read_long_int(blob)
  #       case props_block_number
  #       when PROPS_BLOCK2
  #         #puts "PROPS_BLOCK2 -- key-value pair"
  #         key = read_utf_string(blob)
  #         value = read_utf_string(blob)
  #         puts "#{key}: #{value}"
  #       when PROPS_BLOCK3
  #         #puts "PROPS_BLOCK3 -- key-list pair"
  #         key = read_utf_string(blob)
  #         puts "#{key}:"
  #         value_count = read_long_int(blob)
  #         value_count.times do
  #           value = read_utf_string(blob)
  #           puts "  - #{value}"
  #         end
  #       else
  #         puts "PROPS_UNKNOWN_BLOCK"
  #         exit 1
  #       end
  #     end

  #   when BLOCK5
  #     puts "BLOCK5"

  #     content_type = read_utf_string(blob)
  #     puts "Content Type: #{content_type}"

  #     content_length = read_huge_int(blob)
  #     puts "Content Length: #{content_length}"

  #     file_path = read_utf_string(blob)
  #     puts "File Path: #{file_path}"

  #   when BLOCK6
  #     puts "BLOCK6"
  #     body_size = read_long_int(blob)
  #     if body_size > 0
  #       puts "Body exists in DB record!"
  #       exit 1
  #     end

  #   when BLOCK_END
  #     puts "BLOCK_END: #{blob.pos}"
  #     exit
  #   else
  #     puts "UNKNOWN BLOCK: '#{block_number}'!"
  #     exit
  #   end
  # end

end

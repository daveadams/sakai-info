# sakai-info/content.rb
#   SakaiInfo::Content library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-24 daveadams@gmail.com
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
        if @@cache[id].nil?
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
        DB.connect[:content_resource].select{:sum{:file_size}.as(:total_size)}.
        where(:resource_id.like('#{@id}%')).first[:total_size].to_i
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
end

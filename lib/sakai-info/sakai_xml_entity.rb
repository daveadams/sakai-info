# sakai_xml_entity.rb
#   SakaiInfo::SakaiXMLEntity
#
# Created 2012-02-16 daveadams@gmail.com
# Last updated 2012-02-28 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  # exception class for unrecognized property encodings
  class UnrecognizedPropertyEncodingException < SakaiException
    attr_reader :name, :encoding, :value

    def initialize(name, encoding, value)
      @name = name
      @encoding = encoding
      @value = value

      super("Unrecognized property encoding '#{@encoding}' for property '#{@name}'")
    end
  end

  # This class is the base for Sakai XML-based entities, which are many of the
  # earliest data types in the Sakai database. Most properties of these objects
  # are stored in a large XML clob/text field, and some are base64-encoded as
  # well. Thus each record must be deserialized to read the various properties.
  #
  # Most XML entities consist of a top-level tag representing the entity with
  # a number of attributes attached representing some of the properties of the
  # entity. And then there are "property" tags inside the top-level tag
  # which represent some other properties, including some defaults recording
  # the creator and modifier and the times of those accesses.
  #
  # This class extends SakaiObject and implements some additional
  # serialization methods to reflect the common elements of XML entities.
  class SakaiXMLEntity < SakaiObject
    attr_reader :xml, :xmldoc, :attributes, :properties

    private
    # this method parses the universal XML field for all entities
    # down to two collections: attributes (XML attributes defined in the
    # top-level tag) and properties (<property> tags inside the top-level
    # tag). Properties are generally base64 encoded
    def parse_xml
      @xmldoc = REXML::Document.new(@xml)
      @attributes = {}
      @xmldoc.root.attributes.keys.each do |att_name|
        @attributes[att_name] = @xmldoc.root.attributes[att_name]
      end

      @properties = {}
      REXML::XPath.each(@xmldoc, "//property") do |prop_node|
        prop_name = prop_node.attributes["name"]
        prop_encoding = prop_node.attributes["enc"]
        prop_value = prop_node.attributes["value"]

        if prop_encoding == "BASE64"
          prop_value = Base64.decode64(prop_value)
        else
          raise UnrecognizedPropertyEncodingException.new(prop_name, prop_encoding, prop_value)
        end
        @properties[prop_name] = prop_value
      end
    end

    def format_entity_date(raw)
      raw.gsub(/^(....)(..)(..)(..)(..)(..).*$/, '\1-\2-\3 \4:\5:\6')
    end

    public
    # standard property for all entities
    def created_by
      @created_by ||= User.find(@properties["CHEF:creator"])
    end

    # standard property for all entities
    def modified_by
      @modified_by ||= User.find(@properties["CHEF:modifiedby"])
    end

    # standard property for all entities
    def created_at
      format_entity_date(@properties["DAV:creationdate"])
    end

    # standard property for all entities
    def modified_at
      format_entity_date(@properties["DAV:getlastmodified"])
    end

    # by default, serialize all the common properties
    def default_serialization
      {
        "id" => self.id,
        "created_by" => self.created_by,
        "created_at" => self.created_at,
        "modified_by" => self.modified_by,
        "modified_at" => self.modified_at
      }
    end

    # serialize all attributes
    def attributes_serialization
      {
        "attributes" => @attributes
      }
    end

    # serialize all properties
    def properties_serialization
      {
        "properties" => @properties
      }
    end

    # xml dump serialization option
    def xml_serialization
      {
        "xml" => xml
      }
    end
  end
end

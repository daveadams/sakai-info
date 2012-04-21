# sakai_xml_entity.rb
#   SakaiInfo::SakaiXMLEntity
#
# Created 2012-02-16 daveadams@gmail.com
# Last updated 2012-04-21 daveadams@gmail.com
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

    include ModProps
    created_by_key :_xml_entity_created_by
    created_at_key :_xml_entity_created_at
    modified_by_key :_xml_entity_modified_by
    modified_at_key :_xml_entity_modified_at

    # this method parses the universal XML field for all entities
    # down to two collections: attributes (XML attributes defined in the
    # top-level tag) and properties (<property> tags inside the top-level
    # tag). Properties are generally base64 encoded
    def parse_xml
      if @xml.nil?
        @xml = ""
        REXML::Document.new(@dbrow[:xml].read).write(@xml, 2)
      end

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

      @dbrow[:_xml_entity_created_by] = @properties["CHEF:creator"]
      @dbrow[:_xml_entity_modified_by] = @properties["CHEF:modifiedby"]
      @dbrow[:_xml_entity_created_at] = Util.format_entity_date(@properties["DAV:creationdate"])
      @dbrow[:_xml_entity_modified_at] = Util.format_entity_date(@properties["DAV:getlastmodified"])
    end

    # serialize all attributes
    def attributes_serialization
      {
        "attributes" => self.attributes
      }
    end

    # serialize all properties
    def properties_serialization
      {
        "properties" => self.properties
      }
    end

    # xml dump serialization option
    def xml_serialization
      {
        "xml" => self.xml
      }
    end

    # tweak the dbrow out since we hacked dbrow for other purposes
    # and since the xml field doesn't display typically
    def dbrow_serialization
      dbrow = super["dbrow"]
      dbrow[:xml] = self.xml
      dbrow.delete(:_xml_entity_created_by)
      dbrow.delete(:_xml_entity_created_at)
      dbrow.delete(:_xml_entity_modified_by)
      dbrow.delete(:_xml_entity_modified_at)

      {
        "dbrow" => dbrow
      }
    end

    def self.all_serializations
      [ :default, :attributes, :properties, :xml ]
    end
  end
end

# sakai-info.rb
#   Base library file
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-16 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'yaml'
require 'json'
require 'rexml/document'
require 'base64'

module SakaiInfo
  # base exception class for distinguishing SakaiInfo exceptions
  # from Ruby exceptions
  class SakaiException < Exception; end

  # exception to be raised when an object of a certain type cannot be found
  class ObjectNotFoundException < SakaiException
    def initialize(classname, identifier)
      @classname = classname
      @identifier = identifier

      super("Could not find a #{@classname} object for '#{@identifier}'")
    end
  end
end

# extensions to other objects
class String
  def is_uuid?
    self =~ /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i
  end
end

# all other libs are included here
require 'sakai-info/config'
require 'sakai-info/sakai_object'
require 'sakai-info/sakai_xml_entity'

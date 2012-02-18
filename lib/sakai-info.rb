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

# baseline config and connectivity
require 'sakai-info/config'
require 'sakai-info/db'

# base objects
require 'sakai-info/sakai_object'
require 'sakai-info/sakai_xml_entity'

# sakai object classes
require 'sakai-info/user'
require 'sakai-info/site'
require 'sakai-info/announcement'
require 'sakai-info/assignment'
require 'sakai-info/authz'
require 'sakai-info/content'
require 'sakai-info/gradebook'
require 'sakai-info/group'
require 'sakai-info/message'
require 'sakai-info/samigo'


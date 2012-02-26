# sakai-info.rb
#   Base library file
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-25 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'yaml'
require 'json'
require 'rexml/document'
require 'base64'
require 'sequel'
require 'logger'

require 'sakai-info/version'

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

  class Util
    # misc support functions
    FILESIZE_LABELS = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
    def self.format_filesize(i_size)
      size = i_size.to_f
      negative = false

      if size < 0
        negative = true
        size = -size
      end

      label = 0
      (FILESIZE_LABELS.size - 1).times do
        if size >= 1024.0
          size = size / 1024.0
          label += 1
        end
      end

      if size >= 100.0 or label == 0
        "#{negative ? "-" : ""}#{size.to_i.to_s} #{FILESIZE_LABELS[label]}"
      else
        "#{negative ? "-" : ""}#{sprintf("%.1f", size)} #{FILESIZE_LABELS[label]}"
      end
    end
  end
end

# extensions to other objects
class String
  def is_uuid?
    self =~ /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i
  end
end

# baseline db connectivity
require 'sakai-info/database'

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
require 'sakai-info/question_pool'


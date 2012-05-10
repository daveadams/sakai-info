# sakai-info.rb
#   Base library file
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-05-10 daveadams@gmail.com
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

    def self.format_entity_date(raw)
      if raw =~ /^(....)(..)(..)(..)(..)(..).*$/
        # I believe these are usually in UTC
        Time.utc($1.to_i, $2.to_i, $3.to_i, $4.to_i, $5.to_i, $6.to_i).getlocal
      else
        raw
      end
    end
  end

  # cache control
  class Cache
    def self.clear_all
      SakaiObject.descendants.select { |klass|
        klass.methods.include? :clear_cache
      }.each { |klass|
        klass.clear_cache
      }
    end
  end
end

######################################################################
# extensions to other objects
class String
  def is_uuid?
    self =~ /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i
  end
end

# terrible hack to work around mysql case issues
# essentially, if the hash key asked for is a symbol and its value is
# nil, then try again with the uppercased version of the symbol
# this might cause problems in weird cases with other hashes, this is
# definitely not a sustainable fix.
# TODO: patch Sequel for case-insensitive/-fixed identifiers
class Hash
  alias :original_brackets :[]

  def [](key)
    if not (value = original_brackets(key)).nil?
      return value
    else
      if key.is_a? Symbol
        return original_brackets(key.to_s.upcase.to_sym)
      else
        return nil
      end
    end
  end
end

# alias .to_s on Blob class to match OCI8 blob class's read method
module Sequel
  module SQL
    class Blob
      alias :read :to_s
    end
  end
end

# baseline db connectivity
require 'sakai-info/database'

# base objects
require 'sakai-info/mod_props'
require 'sakai-info/sakai_object'
require 'sakai-info/sakai_xml_entity'

# sakai object classes
require 'sakai-info/user'
require 'sakai-info/site'
require 'sakai-info/page'
require 'sakai-info/tool'
require 'sakai-info/announcement'
require 'sakai-info/assignment'
require 'sakai-info/authz'
require 'sakai-info/content'
require 'sakai-info/gradebook'
require 'sakai-info/group'
require 'sakai-info/quiz'
require 'sakai-info/question_pool'
require 'sakai-info/generic_message'
require 'sakai-info/forum'


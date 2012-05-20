# hacks.rb
#   Hacks necessary to work around problems in external libraries
#
# Created 2012-05-20 daveadams@gmail.com
# Last updated 2012-05-20 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

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

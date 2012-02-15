# sakai-info.rb
#   Base library file
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-15 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

class SakaiInfo
  class Config
  end

  class DB
  end

  class SakaiException < Exception
  end

  class SakaiObject
  end

  class SakaiXMLEntity < SakaiObject
  end
end

# extensions to other objects
class String
  def is_uuid?
    self =~ /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i
  end
end

# TODO: include other libs here


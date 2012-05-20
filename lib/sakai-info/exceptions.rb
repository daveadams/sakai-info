# exceptions.rb
#   Special exception definitions
#
# Created 2012-05-20 daveadams@gmail.com
# Last updated 2012-05-20 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

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


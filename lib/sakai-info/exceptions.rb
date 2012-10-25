# exceptions.rb
#   Special exception definitions
#
# Created 2012-05-20 daveadams@gmail.com
# Last updated 2012-10-25 daveadams@gmail.com
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
    def initialize(missing_class, identifier)
      @missing_class = missing_class
      @identifier = identifier

      super("Could not find a #{@missing_class.name} object for '#{@identifier}'")
    end

    def classname
      @missing_class.name
    end
  end
end


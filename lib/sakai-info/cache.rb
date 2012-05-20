# cache.rb
#   Cache control
#
# Created 2012-05-20 daveadams@gmail.com
# Last updated 2012-05-20 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
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

# sakai-info/db.rb
#   SakaiInfo::DB library
#
# Created 2012-02-16 daveadams@gmail.com
# Last updated 2012-02-19 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class DB
    def self.connect(instance_name = :default)
      Config.get_instance(instance_name).connect
    end
  end
end


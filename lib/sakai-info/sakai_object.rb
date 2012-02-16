# sakai_object.rb
#   SakaiInfo::SakaiObject
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-16 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  # this class forms the basis of all other Sakai object abstractions
  class SakaiObject
    def serialize(*q)
      q.flatten!

      if q.length == 0
        q = [:default]
      end

      serialization = {}
      q.each do |sub|
        sub_method_name = (sub.to_s + "_serialization").to_sym
        begin
          sub_method = self.method(sub_method_name)
          serialization = serialization.merge(sub_method.call)
        rescue NameError
          # ignore any missing serialization patterns
        end
      end

      serialization
    end

    def default_serialization
      {
        "sakai_object_type" => self.class
      }
    end

    def to_yaml
      serialize.to_yaml
    end

    def to_json
      serialize.to_json
    end
  end
end

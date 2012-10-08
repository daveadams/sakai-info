# sakai_object.rb
#   SakaiInfo::SakaiObject
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-10-08 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  # this class forms the basis of all other Sakai object abstractions
  class SakaiObject
    # most objects will have unique IDs
    # (perhaps the rest should generate their own?)
    attr_reader :id

    def serialize(*q)
      q.flatten!

      if q.length == 0
        q = [:default]
      end

      serialization = {}
      q.each do |sub|
        sub_method_name = (sub.to_s + "_serialization").to_sym
        if self.respond_to? sub_method_name
          serialization = serialization.merge(self.method(sub_method_name).call)
        end
      end

      serialization
    end

    def object_type_serialization
      {
        "sakai_object_type" => self.class
      }
    end

    def dbrow_serialization
      if self.respond_to? :dbrow
        {
          "dbrow" => self.dbrow
        }
      else
        {}
      end
    end

    def dbrow_only_serialization
      if not self.dbrow_serialization["dbrow"].nil?
        self.dbrow_serialization["dbrow"]
      else
        {}
      end
    end

    def default_serialization
      object_type_serialization
    end

    def summary_serialization
      default_serialization
    end

    def shell_serialization
      summary_serialization
    end

    def to_yaml(*q)
      serialize(q).to_yaml
    end

    def to_json(*q)
      serialize(q).to_json
    end

    def to_csv(*fields)
      values = []
      fields.each do |field|
        m = self.method(field.to_sym)
        next if m.nil?
        values << m.call.to_s
      end
      values.collect{|v|"\"#{v}\""}.join(",")
    end

    # support for CLI -- returns an array of symbols that can be
    # passed back to #serialize, #to_yaml, or #to_json
    # should be reimplemented in all object classes
    def self.all_serializations
      [:default]
    end

    # keep track of descendants
    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end
  end
end

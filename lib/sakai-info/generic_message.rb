# sakai-info/generic_message.rb
#   SakaiInfo::GenericMessage library
#
# Created 2012-04-01 daveadams@gmail.com
# Last updated 2012-04-01 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class UnknownMessageTypeException < SakaiException; end
  class GenericMessage < SakaiObject
    def self.types
      {
        "ME" => "Forum Post",
        "PM" => "Private Message"
      }
    end

    def self.valid_message_type?(mt)
      GenericMessage.types.keys.include?(mt)
    end

    def self.count_by_date_and_message_type(count_date, message_type)
      date_str = nil
      if count_date.is_a? Time
        date_str = count_date.strftime("%Y-%m-%d")
      elsif count_date.is_a? String
        if count_date =~ /^\d\d\d\d-\d\d-\d\d$/
          date_str = count_date
        else
          raise InvalidDateException
        end
      else
        raise InvalidDateException
      end

      if not valid_message_type? message_type
        raise UnknownMessageTypeException
      end

      DB.connect.fetch("select count(*) as count from mfr_message_t " +
                       "where message_dtype = ? and " +
                       "to_char(created,'YYYY-MM-DD') = ? ",
                       message_type, date_str).first[:count].to_i
    end
  end

  class GenericThread < SakaiObject
    def self.types
      {
        "TO" => "Generic Thread",
        "PT" => "Private Thread",
        "OT" => "Open Thread",
        "DT" => "Discussion Thread"
      }
    end

    def self.valid_message_type?(mt)
      GenericThread.types.keys.include?(mt)
    end
  end
end



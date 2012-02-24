# sakai-info/message.rb
#   SakaiInfo::Message library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-24 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class MessageTypeUUID
    # TODO: verify whether these are the same in all installs
    PRIVATE_MESSAGE = "d6404db7-7f6e-487a-00fe-baffce45d84c"
    FORUM_POST = "7143223e-355a-4865-00dd-cee9310499e4"
  end

  class UnknownMessageTypeException < SakaiException; end
  class GenericMessage < SakaiObject
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

      count = 0
      DB.connect.exec("select count(*) from mfr_message_t " +
                      "where message_dtype = :t " +
                      "and to_char(created,'YYYY-MM-DD') = :d",
                      message_type, date_str) do |row|
        count = row[0].to_i
      end
      count
    end

   private
    def self.valid_message_type?(s)
      s =="ME" or s =="PM"
    end
  end

  class PrivateMessage < GenericMessage
    def self.count_by_date(d)
      count_by_date_and_message_type(d, "PM")
    end
  end

  class ForumPost < GenericMessage
    def self.count_by_date(d)
      count_by_date_and_message_type(d, "ME")
    end
  end

  class Forum < SakaiObject
    attr_reader :id, :title

    def initialize(id, title)
      @id = id.to_i
      @title = title
    end

    @@cache = {}

    def self.count_by_site_id(site_id)
      DB.connect.fetch("select count(*) as count from mfr_open_forum_t " +
                       "where surrogatekey = (select id from mfr_area_t " +
                       "where type_uuid = ? and context_id = ?)",
                       MessageTypeUUID::FORUM_POST, site_id).first[:count].to_i
    end

    @@cache_by_site_id = {}
    def self.find_by_site_id(site_id)
      if @@cache_by_site_id[site_id].nil?
        @@cache_by_site_id[site_id] = []
        DB.connect.exec("select id, title from mfr_open_forum_t " +
                        "where surrogatekey = (select id from mfr_area_t " +
                        "where type_uuid = :type_uuid " +
                        "and context_id = :site_id) order by sort_index",
                        MessageTypeUUID::FORUM_POST, site_id) do |row|
          id = row[0].to_i.to_s
          title = row[1]
          @@cache[id] = Forum.new(id, title)
          @@cache_by_site_id[site_id] << @@cache[id]
        end
      end
      @@cache_by_site_id[site_id]
    end

    def default_serialization
      {
        "id" => self.id,
        "title" => self.title
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title
      }
    end
  end
end


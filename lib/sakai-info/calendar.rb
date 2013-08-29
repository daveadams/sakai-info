# sakai-info/calendar.rb
#   SakaiInfo::Calendar library
#
# Created 2013-08-29 daveadams@gmail.com
# Last updated 2013-08-29 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Calendar < SakaiXMLEntity
    attr_reader :dbrow, :next_id

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(dbrow)
      @dbrow = dbrow
      @id = dbrow[:calendar_id]
      @next_id = dbrow[:next_id]

      parse_xml
    end

    def self.find(id)
      if @@cache[id].nil?
        xml = ""
        row = DB.connect[:calendar_calendar].where(:calendar_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(Calendar, id)
        end
        @@cache[id] = Calendar.new(row)
      end
      @@cache[id]
    end

    # def self.find_by_site_id(site_id)
    #   @@site_cache[site_id] ||=
    #     if site_id == "!site"
    #       self.find("/announcement/channel/#{site_id}/motd")
    #     else
    #       self.find("/announcement/channel/#{site_id}/main")
    #     end
    # end

    # lazy properties
    # def events
    #   @events ||= CalendarEvent.find_by_calendar_id(@id)
    # end

    # def event_count
    #   @event_count ||= CalendarEvent.count_by_calendar_id(@id)
    # end

    # def site_id
    #   @site_id ||= @id.split("/")[3]
    # end

    def xml
      if @xml.nil?
        @xml = ""
        REXML::Document.new(@dbrow[:xml].read).write(@xml, 2)
      end
      @xml
    end

    # serialization
    def default_serialization
      {
        "id" => self.id,
        "next_id" => self.next_id,
      }
    end

    def summary_serialization
      {
        "id" => self.id,
      }
    end

    def xml_serialization
      {
        "xml" => self.xml
      }
    end

    # def announcements_serialization
    #   {
    #     "announcements" => self.announcements.collect { |ann| ann.serialize(:summary) }
    #   }
    # end

    def self.all_serializations
      [
       :default,
       :xml,
       :announcements,
      ]
    end
  end
end

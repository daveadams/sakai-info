# sakai-info/calendar.rb
#   SakaiInfo::Calendar library
#
# Created 2013-08-29 daveadams@gmail.com
# Last updated 2013-08-30 daveadams@gmail.com
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
      # if there's no slash in the id string, assume it's a site id
      if id !~ /\//
        id = "/calendar/calendar/#{id}/main"
      end

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

    def self.find!(id)
      begin
        Calendar.find(id)
      rescue ObjectNotFoundException => e
        if e.classname == Calendar.name
          MissingCalendar.find(id)
        end
      end
    end

    # lazy properties
    def events
      @events ||= CalendarEvent.find_by_calendar_id(@id)
    end

    def event_count
      @event_count ||= CalendarEvent.count_by_calendar_id(@id)
    end

    def site_id
      @site_id ||= @id.split("/")[3]
    end

    def site
      @site ||= Site.find(self.site_id)
    end

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
        "site" => self.site.serialize(:summary),
        "next_id" => self.next_id,
        "event_count" => self.event_count,
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

    def events_serialization
      {
        "events" => self.events.collect{|e|e.serialize(:summary)}
      }
    end

    def self.all_serializations
      [
       :default,
       :xml,
       :mod,
       :events,
      ]
    end
  end

  class MissingCalendar < Calendar
    def initialize(row)
      @dbrow = row

      @id = @dbrow[:id]
    end

    def self.find(id)
      MissingCalendar.new({:id => id})
    end

    def event_count
      0
    end

    def events
      []
    end

    def default_serialization
      {
        "status" => "No Calendar for #{self.id}",
      }
    end

    def summary_serialization
      {
        "status" => "No Calendar",
      }
    end

    def self.all_serializations
      [
       :default,
      ]
    end
  end

  class CalendarEvent < SakaiXMLEntity
    attr_reader :dbrow, :calendar_id, :event_start, :event_end, :range_start, :range_end

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(dbrow)
      @dbrow = dbrow
      @id = dbrow[:event_id]
      @calendar_id = dbrow[:calendar_id]
      @range_start = dbrow[:range_start]
      @range_end = dbrow[:range_end]

      parse_xml
    end

    def self.find(id)
      if @@cache[id].nil?
        xml = ""
        row = DB.connect[:calendar_event].where(:event_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(CalendarEvent, id)
        end
        @@cache[id] = CalendarEvent.new(row)
      end
      @@cache[id]
    end

    def event_start
      @event_start ||= dbrow[:event_start]
    end

    def event_end
      @event_end ||= dbrow[:event_end]
    end

    def self.query_by_calendar_id(calendar_id)
      DB.connect[:calendar_event].where(:calendar_id => calendar_id)
    end

    def self.count_by_calendar_id(calendar_id)
      CalendarEvent.query_by_calendar_id(calendar_id).count
    end

    def self.find_by_calendar_id(calendar_id)
      CalendarEvent.query_by_calendar_id(calendar_id).all.collect do |row|
        @@cache[row[:event_id]] = CalendarEvent.new(row)
      end
    end

    def calendar
      @calendar ||= Calendar.find(self.calendar_id)
    end

    def display_name
      @display_name ||= self.properties["DAV:displayname"]
    end

    def description
      @description ||= self.properties["CHEF:description"]
    end

    def type
      @type ||= self.properties["CHEF:calendar-type"]
    end

    # serialization
    def default_serialization
      {
        "id" => self.id,
        "calendar_id" => self.calendar_id,
        "display_name" => self.display_name,
        "description" => self.description,
        "type" => self.type,
        "event_start" => self.event_start,
        "event_end" => self.event_end,
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "display_name" => self.display_name,
        "type" => self.type,
        "event_start_date" => self.event_start.strftime("%Y-%m-%d"),
      }
    end

    def xml_serialization
      {
        "xml" => self.xml
      }
    end

    def self.all_serializations
      [
       :default,
       :attributes,
       :properties,
       :mod,
       :xml,
      ]
    end
  end
end

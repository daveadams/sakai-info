# sakai-info/announcement.rb
#   SakaiInfo::Announcement library
#
# Created 2012-02-16 daveadams@gmail.com
# Last updated 2012-05-10 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class AnnouncementChannel < SakaiObject
    attr_reader :dbrow

    def self.clear_caches
      @@cache = {}
      @@site_cache = {}
    end
    clear_caches

    def initialize(dbrow)
      @dbrow = dbrow
      @id = dbrow[:channel_id]
    end

    def self.find(id)
      if @@cache[id].nil?
        xml = ""
        row = DB.connect[:announcement_channel].where(:channel_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(AnnouncementChannel, id)
        end
        @@cache[id] = AnnouncementChannel.new(row)
        @@site_cache[@@cache[id].site_id] = @@cache[id]
      end
      @@cache[id]
    end

    def self.find_by_site_id(site_id)
      @@site_cache[site_id] ||=
        if site_id == "!site"
          self.find("/announcement/channel/#{site_id}/motd")
        else
          self.find("/announcement/channel/#{site_id}/main")
        end
    end

    # lazy properties
    def announcements
      @announcements ||= Announcement.find_by_channel_id(@id)
    end

    def announcement_count
      @announcement_count ||= Announcement.count_by_channel_id(@id)
    end

    def site_id
      @site_id ||= @id.split("/")[3]
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
        "site_id" => self.site_id,
        "announcement_count" => self.announcement_count
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "announcement_count" => self.announcement_count
      }
    end

    def xml_serialization
      {
        "xml" => self.xml
      }
    end

    def announcements_serialization
      {
        "announcements" => self.announcements.collect { |ann| ann.serialize(:summary) }
      }
    end

    def self.all_serializations
      [
       :default,
       :xml,
       :announcements,
      ]
    end
  end

  class Announcement < SakaiObject
    attr_reader :channel_id, :owner, :date, :draft, :pubview, :dbrow

    def self.clear_caches
      @@cache = {}
    end
    clear_caches

    def initialize(dbrow)
      @dbrow = dbrow

      @id = @dbrow[:message_id]
      @channel_id = @dbrow[:channel_id]
      @draft = @dbrow[:draft]
      @pubview = @dbrow[:pubview]
      @owner = User.find(@dbrow[:owner])
      @date = @dbrow[:message_date]
    end

    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:announcement_message].where(:message_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(Announcement, id)
        end
        @@cache[id] = Announcement.new(row)
      end
      @@cache[id]
    end

    def self.query_by_channel_id(channel_id)
      DB.connect[:announcement_message].where(:channel_id => channel_id)
    end

    def self.count_by_channel_id(channel_id)
      Announcement.query_by_channel_id(channel_id).count
    end

    def self.find_by_channel_id(channel_id)
      Announcement.query_by_channel_id(channel_id).all.collect do |row|
        @@cache[row[:message_id]] = Announcement.new(row)
      end
    end

    # lazy properties
    def channel
      @channel ||= AnnouncementChannel.find(self.channel_id)
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
        "date" => self.date,
        "owner" => self.owner.serialize(:summary),
        "draft" => self.draft,
        "pubview" => self.pubview,
        "channel" => self.channel_id,
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "date" => self.date
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
       :xml,
      ]
    end
  end
end


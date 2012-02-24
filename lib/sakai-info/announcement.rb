# sakai-info/announcement.rb
#   SakaiInfo::Announcement library
#
# Created 2012-02-16 daveadams@gmail.com
# Last updated 2012-02-24 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class AnnouncementChannel < SakaiXMLEntity
    attr_reader :next

    @@cache = {}
    @@site_cache = {}

    def self.find(id)
      if @@cache[id].nil?
        xml = ""
        row = DB.connect[:announcement_channel].filter(:channel_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(AnnouncementChannel, id)
        end
        nextid = row[:next_id].to_i
        REXML::Document.new(row[:xml].read).write(xml, 2)
        channel = AnnouncementChannel.new(id, nextid, xml)
        @@cache[id] = channel
        @@site_cache[channel.site_id] = channel
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

    # raw data constructor
    def initialize(id, nextid, xml)
      @id = id
      @next = nextid
      @xml = xml
      parse_xml
    end

    # properties
    def announcements
      @announcements ||= Announcement.find_by_channel_id(@id)
    end

    def announcement_count
      @announcement_count ||= self.announcements.length
    end

    def site_id
      @site_id ||= @id.split("/")[3]
    end

    # serialization
    def default_serialization
      {
        "id" => self.id,
        "next" => self.next,
        "site_id" => self.site_id,
        "announcement_count" => self.announcement_count
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "site_id" => self.site_id,
        "announcement_count" => self.announcement_count
      }
    end
  end

  class Announcement < SakaiXMLEntity
    attr_reader :channel, :owner, :date
    attr_reader :draft, :pubview

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        xml = ""
        row = DB.connect.fetch("select channel_id, draft, pubview, owner, xml, " +
                               "to_char(message_date,'YYYY-MM-DD HH24:MI:SS') as date " +
                               "from announcement_message " +
                               "where message_id = ?", id).first
        if row.nil?
          raise ObjectNotFoundException.new(Announcement, id)
        end

        channel = AnnouncementChannel.find(row[:channel_id])
        draft = row[:draft]
        pubview = row[:pubview]
        owner = User.find(row[:owner])
        date = row[:date]
        REXML::Document.new(row[:xml].read).write(xml, 2)
        @@cache[id] = Announcement.new(id, channel, draft, pubview, owner, date, xml)
      end
      @@cache[id]
    end

    # raw data constructor
    def initialize(id, channel, draft, pubview, owner, date, xml)
      @id = id
      @channel = channel
      @draft = draft
      @pubview = pubview
      @owner = owner
      @date = date
      @xml = xml
      parse_xml
    end

    # helpers
    def self.find_by_channel_id(channel_id)
      announcements = []
      channel = AnnouncementChannel.find(channel_id)

      DB.connect.fetch("select message_id, draft, pubview, owner, xml, " +
                       "to_char(message_date,'YYYY-MM-DD HH24:MI:SS') as date " +
                       "from announcement_message " +
                       "where channel_id = ?", channel_id) do |row|
        xml = ""
        id = row[:message_id]
        draft = row[:draft]
        pubview = row[:pubview]
        owner = User.find(row[:owner])
        REXML::Document.new(row[:xml].read).write(xml, 2)
        date = row[:date]

        @@cache[id] = Announcement.new(id, channel, draft, pubview, owner, date, xml)
        announcements << @@cache[id]
      end
      announcements
    end

    # serialization
    def default_serialization
      {
        "id" => self.id,
        "date" => self.date,
        "owner" => self.owner.serialize(:summary),
        "draft" => self.draft,
        "pubview" => self.pubview,
        "channel" => self.channel.serialize(:summary)
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "date" => self.date
      }
    end
  end
end


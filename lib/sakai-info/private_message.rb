# sakai-info/private_message.rb
#   SakaiInfo::PrivateMessage library
#
# Created 2012-09-25 daveadams@gmail.com
# Last updated 2012-09-25 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class PrivateMessage < GenericMessage
    attr_reader :id, :title, :dbrow

    include ModProps
    created_by_key :created_by
    created_at_key :created
    modified_by_key :modified_by
    modified_at_key :modified

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def self.find(id)
      if @@cache[id.to_s].nil?
        row = DB.connect[:mfr_message_t].where(:id => id, :message_dtype => "PM").first
        if row.nil?
          raise ObjectNotFoundException.new(PrivateMessage, id)
        end
        @@cache[id.to_s] = PrivateMessage.new(row)
      end
      @@cache[id.to_s]
    end

    def initialize(dbrow)
      @dbrow = dbrow

      @dbrow[:body] = dbrow[:body].read
      @dbrow[:recipients_as_text] = dbrow[:recipients_as_text].read

      @id = dbrow[:id].to_i
      @title = dbrow[:title]
    end

    def author
      # apparently the 'author' field is just a display string?!?
      # as of 2.8, perhaps?
      @author ||= User.find(@dbrow[:created_by])
    end

    def body
      @dbrow[:body]
    end

    def self.count_by_date(d)
      count_by_date_and_message_type(d, "PM")
    end

    def default_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "author" => self.author.serialize(:summary),
        "body" => self.body,
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title,
      }
    end
  end
end

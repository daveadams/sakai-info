# sakai-info/question_pool.rb
#   SakaiInfo::QuestionPool library
#
# Created 2012-02-26 daveadams@gmail.com
# Last updated 2012-02-26 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class QuestionPool < SakaiObject
    attr_reader :title, :owner

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:questionpoolid]
      @title = dbrow[:title]
      @owner = User.find(dbrow[:ownerid])
    end

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:sam_questionpool_t].filter(:questionpoolid => id).first
        if row.nil?
          raise ObjectNotFoundException.new(QuestionPool, id)
        end
        @@cache[id] = QuestionPool.new(row)
      end
      @@cache[id]
    end

    def self.find_by_user_id(user_id)
      results = []
      DB.connect[:sam_questionpool_t].filter(:ownerid => user_id).all.each do |row|
        id = row[:questionpoolid]
        @@cache[id] = QuestionPool.new(row)
        results << @@cache[id]
      end
      results
    end

    def self.count_by_user_id(user_id)
      DB.connect[:sam_questionpool_t].filter(:ownerid => user_id).count
    end

    def item_count
      @item_count ||=
        DB.connect[:sam_questionpoolitem_t].filter(:questionpoolid => @id).count
    end

    # serialization
    def default_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "owner" => self.owner.serialize(:summary),
        "item_count" => self.item_count
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "owner_eid" => self.owner.eid,
        "item_count" => self.item_count
      }
    end

    def user_summary_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "item_count" => self.item_count
      }
    end

    def dbrow_serialization
      {
        "dbrow" => self.dbrow
      }
    end
  end
end

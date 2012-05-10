# sakai-info/question_pool.rb
#   SakaiInfo::QuestionPool library
#
# Created 2012-02-26 daveadams@gmail.com
# Last updated 2012-05-10 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class QuestionPool < SakaiObject
    attr_reader :title, :owner, :description, :parent_pool_id, :dbrow

    include ModProps
    created_at_key :datecreated
    created_by_key :ownerid
    modified_at_key :lastmodifieddate
    modified_by_key :lastmodifiedby

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:questionpoolid]
      @title = dbrow[:title]
      @description = dbrow[:description]
      @owner = User.find(dbrow[:ownerid])
      @parent_pool_id = dbrow[:parentpoolid]
      @parent_pool_id = nil if @parent_pool_id == 0
    end

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

    def parent
      if not @parent_pool_id.nil?
        @parent ||= QuestionPool.find(@parent_pool_id)
      end
    end

    # serialization
    def default_serialization
      result = {
        "id" => self.id,
        "title" => self.title,
        "owner" => self.owner.serialize(:summary),
        "parent" => nil,
        "item_count" => self.item_count
      }
      if not self.parent.nil?
        result["parent"] = self.parent.serialize(:summary)
      else
        result.delete("parent")
      end
      result
    end

    def summary_serialization
      result = {
        "id" => self.id,
        "title" => self.title,
        "owner_eid" => self.owner.eid,
        "parent_pool_id" => self.parent_pool_id,
        "item_count" => self.item_count
      }
      if result["parent_pool_id"].nil?
        result.delete("parent_pool_id")
      end
      result
    end

    def user_summary_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "item_count" => self.item_count
      }
    end
  end
end

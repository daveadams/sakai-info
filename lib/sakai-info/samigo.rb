# sakai-info/samigo.rb
#   SakaiInfo::Samigo library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-24 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class PendingQuiz < SakaiObject
    attr_reader :title, :site

    def initialize(id, title, site)
      @id = id
      @title = title
      @site = site
    end

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:sam_assessmentbase_t].filter(:id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(PendingQuiz, id)
        end
        @@cache[id] = PendingQuiz.new(id, row[0], Site.find(row[1]))
      end
      @@cache[id]
    end

    def self.find_by_site_id(site_id)
      results = []
      site = Site.find(site_id)
      DB.connect.fetch("select id, title from sam_assessmentbase_t " +
                       "where id in (select qualifierid from sam_authzdata_t " +
                       "where agentid=? and functionid='EDIT_ASSESSMENT')",
                       site_id) do |row|
        @@cache[row[:id]] = PendingQuiz.new(row[:id].to_i, row[:title], site)
        results << @@cache[row[:id]]
      end
      results
    end

    def self.count_by_site_id(site_id)
      DB.connect.fetch("select count(*) as count from sam_publishedassessment_t " +
                       "where id in (select qualifierid from sam_authzdata_t " +
                       "where agentid=? and functionid='EDIT_ASSESSMENT')",
                       site_id).first[:count].to_i
    end

    def default_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "site_id" => self.site.id
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title
      }
    end
  end

  class PublishedQuiz < SakaiObject
    attr_reader :title, :site

    def initialize(id, title, site)
      @id = id
      @title = title
      @site = site
    end

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:sam_publishedassessment_t].filter(:id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(PublishedQuiz, id)
        end

        @@cache[id] = PublishedQuiz.new(id, row[:title], Site.find(row[:agent_id]))
      end
      @@cache[id]
    end

    def self.find_by_site_id(site_id)
      results = []
      site = Site.find(site_id)
      DB.connect.fetch("select id, title from sam_publishedassessment_t " +
                       "where id in (select qualifierid from sam_authzdata_t " +
                       "where agentid=? and functionid='OWN_PUBLISHED_ASSESSMENT')",
                       site_id) do |row|
        @@cache[row[:id]] = PublishedQuiz.new(row[:id].to_i, row[:title], site)
        results << @@cache[row[:id]]
      end
      results
    end

    def self.count_by_site_id(site_id)
      DB.connect.fetch("select count(*) as count from sam_publishedassessment_t " +
                       "where id in (select qualifierid from sam_authzdata_t " +
                       "where agentid=? and functionid='OWN_PUBLISHED_ASSESSMENT')",
                       site_id).first[:count].to_i
    end

    def default_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "site_id" => self.site.id
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title
      }
    end
  end

  class QuestionPool < SakaiObject
    attr_reader :title, :owner

    def initialize(id, title, owner)
      @id = id
      @title = title
      @owner = owner
    end

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:sam_questionpool_t].filter(:id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(QuestionPool, id)
        end
        @@cache[id] = QuestionPool.new(id, row[:title], User.find(row[:owner_id]))
      end
      @@cache[id]
    end

    def self.find_by_user_id(user_id)
      results = []
      user = User.find(user_id)
      DB.connect[:sam_questionpool_t].filter(:ownerid => user_id) do |row|
        @@cache[row[:questionpoolid]] =
          QuestionPool.new(row[:questionpoolid].to_i, row[:title], user)
        results << @@cache[row[:questionpoolid]]
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
  end
end

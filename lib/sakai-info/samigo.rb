# sakai-info/samigo.rb
#   SakaiInfo::Samigo library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-18 daveadams@gmail.com
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
        DB.connect.exec("select title, agent_id from sam_assessmentbase_t " +
                        "where id=:quizid", id) do |row|
          @@cache[id] = PendingQuiz.new(id, row[0], Site.find(row[1]))
        end
        if @@cache[id].nil?
          raise ObjectNotFoundException.new(PendingQuiz, id)
        end
      end
      @@cache[id]
    end

    def self.find_by_site_id(site_id)
      results = []
      site = Site.find(site_id)
      DB.connect.exec("select id, title from sam_assessmentbase_t " +
                      "where id in (select qualifierid from sam_authzdata_t " +
                      "where agentid=:site_id and " +
                      "functionid='EDIT_ASSESSMENT')", site_id) do |row|
        @@cache[row[0]] = PendingQuiz.new(row[0].to_i, row[1], site)
        results << @@cache[row[0]]
      end
      results
    end

    def self.count_by_site_id(site_id)
      count = 0
      DB.connect.exec("select count(*) from sam_publishedassessment_t " +
                      "where id in (select qualifierid from sam_authzdata_t " +
                      "where agentid=:site_id and " +
                      "functionid='EDIT_ASSESSMENT')", site_id) do |row|
        count = row[0].to_i
      end
      count
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
        DB.connect.exec("select title, agent_id from sam_publishedassessment_t " +
                        "where id=:quizid", id) do |row|
          @@cache[id] = PublishedQuiz.new(id, row[0], Site.find(row[1]))
        end
        if @@cache[id].nil?
          raise ObjectNotFoundException.new(PublishedQuiz, id)
        end
      end
      @@cache[id]
    end

    def self.find_by_site_id(site_id)
      results = []
      site = Site.find(site_id)
      DB.connect.exec("select id, title from sam_publishedassessment_t " +
                      "where id in (select qualifierid from sam_authzdata_t " +
                      "where agentid=:site_id and " +
                      "functionid='OWN_PUBLISHED_ASSESSMENT')", site_id) do |row|
        @@cache[row[0]] = PublishedQuiz.new(row[0].to_i, row[1], site)
        results << @@cache[row[0]]
      end
      results
    end

    def self.count_by_site_id(site_id)
      count = 0
      DB.connect.exec("select count(*) from sam_publishedassessment_t " +
                      "where id in (select qualifierid from sam_authzdata_t " +
                      "where agentid=:site_id " +
                      "and functionid='OWN_PUBLISHED_ASSESSMENT')", site_id) do |row|
        count = row[0].to_i
      end
      count
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
        DB.connect.exec("select title, ownerid from sam_questionpool_t " +
                        "where questionpoolid=:id", id) do |row|
          @@cache[id] = QuestionPool.new(id, row[0], User.find(row[1]))
        end
        if @@cache[id].nil?
          raise ObjectNotFoundException.new(QuestionPool, id)
        end
      end
      @@cache[id]
    end

    def self.find_by_user_id(user_id)
      results = []
      user = User.find(user_id)
      DB.connect.exec("select questionpoolid, title from sam_questionpool_t " +
                      "where ownerid=:userid", user_id) do |row|
        @@cache[row[0]] = QuestionPool.new(row[0].to_i, row[1], user)
        results << @@cache[row[0]]
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

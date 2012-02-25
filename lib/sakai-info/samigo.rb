# sakai-info/samigo.rb
#   SakaiInfo::Samigo library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-25 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Quiz < SakaiObject
    attr_reader :title, :site, :dbrow

    def initialize(row, site = nil)
      @site = nil
      if site.is_a? String
        begin
          @site = Site.find(site)
        rescue ObjectNotFoundException
          @site = nil
        end
      elsif site.is_a? Site
        @site = site
      end

      if @site.nil?
        # TODO: lookup site via other tables
      end

      @id = row[:id]
      @title = row[:title]
      @dbrow = row
    end

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        quiz = nil
        begin
          quiz = PendingQuiz.find(id)
        rescue ObjectNotFoundException
          begin
            quiz = PublishedQuiz.find(id)
          rescue ObjectNotFoundException
            raise ObjectNotFoundException.new(Quiz, id)
          end
        end
        @@cache[id] = quiz
      end
      @@cache[id]
    end

    def self.find_by_site_id(site_id)
      {
        "pending" => PendingQuiz.find_by_site_id(site_id),
        "published" => PublishedQuiz.find_by_site_id(site_id)
      }
    end

    def self.count_by_site_id(site_id)
      {
        "pending_count" => PendingQuiz.count_by_site_id(site_id),
        "published_count" => PublishedQuiz.count_by_site_id(site_id)
      }
    end
  end

  class PendingQuiz < Quiz
    @@cache = {}
    def self.find(id)
      if @@cache[id.to_s].nil?
        row = DB.connect[:sam_assessmentbase_t].filter(:id => id.to_i).first
        if row.nil?
          raise ObjectNotFoundException.new(PendingQuiz, id)
        end
        @@cache[id] = PendingQuiz.new(row)
      end
      @@cache[id]
    end

    def self.query_by_site_id(site_id)
      db = DB.connect
      db[:sam_assessmentbase_t].
        where(:id =>
              db[:sam_authzdata_t].select(:qualifierid).
              where(:agentid => site_id,
                    :functionid => "EDIT_ASSESSMENT"))
    end

    def self.find_by_site_id(site_id)
      results = []
      PendingQuiz.query_by_site_id(site_id).all.each do |row|
        @@cache[row[:id]] = PendingQuiz.new(row, site_id)
        results << @@cache[row[:id]]
      end
      results
    end

    def self.count_by_site_id(site_id)
      PendingQuiz.query_by_site_id(site_id).count
    end

    def default_serialization
      {
        "id" => self.id,
        "title" => self.title,
        # "site_id" => self.site.id,
        "status" => "pending"
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title
      }
    end
  end

  class PublishedQuiz < Quiz
    @@cache = {}
    def self.find(id)
      if @@cache[id.to_s].nil?
        row = DB.connect[:sam_publishedassessment_t].filter(:id => id.to_i).first
        if row.nil?
          raise ObjectNotFoundException.new(PublishedQuiz, id)
        end

        @@cache[id] = PublishedQuiz.new(row)
      end
      @@cache[id]
    end

    def self.query_by_site_id(site_id)
      db = DB.connect
      db[:sam_publishedassessment_t].
        where(:id =>
              db[:sam_authzdata_t].select(:qualifierid).
              where(:agentid => site_id,
                    :functionid => "OWN_PUBLISHED_ASSESSMENT"))
    end

    def self.find_by_site_id(site_id)
      results = []
      PublishedQuiz.query_by_site_id(site_id).all.each do |row|
        @@cache[row[:id]] = PublishedQuiz.new(row, site_id)
        results << @@cache[row[:id]]
      end
      results
    end

    def self.count_by_site_id(site_id)
      PublishedQuiz.query_by_site_id(site_id).count
    end

    def default_serialization
      {
        "id" => self.id,
        "title" => self.title,
        # "site_id" => self.site.id,
        "status" => "published"
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
      DB.connect[:sam_questionpool_t].filter(:ownerid => user_id).all.each do |row|
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

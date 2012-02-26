# sakai-info/quiz.rb
#   SakaiInfo::Quiz library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-26 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Quiz < SakaiObject
    attr_reader :title, :site, :dbrow

    include ModProps
    created_by_key :createdby
    created_at_key :createddate
    modified_by_key :lastmodifiedby
    modified_at_key :lastmodifieddate

    # a note about quizzes:
    # they do not link directly back to sites
    # instead, they link back only via the sam_authzdata_t table
    def initialize(dbrow, site = nil)
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

      @id = dbrow[:id]
      @title = dbrow[:title]
      @dbrow = dbrow

      if @site.nil?
        # published quizzes map to site_id via the OWN_PUBLISHED_ASSESSMENT function
        # pending quizzes map to site_id via the EDIT_ASSESSMENT function
        DB.connect[:sam_authzdata_t].select(:distinct.sql_function(:agentid)).
          where(:qualifierid => @id).
          where(:functionid => ["OWN_PUBLISHED_ASSESSMENT","EDIT_ASSESSMENT"]).
          all.each do |row|
          begin
            site = Site.find(row[:agentid])
            @site = site
          rescue ObjectNotFoundException
            @site = nil
          end
          break if not @site.nil?
        end
      end
    end

    @@cache = {}
    def self.find(id)
      id = id.to_s
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

    def quiz_type
      nil
    end

    def section_count
      @section_count ||= QuizSection.count_by_quiz_id(@id)
    end

    def default_serialization
      result = {
        "id" => self.id,
        "title" => self.title,
        "site" => nil,
        "type" => self.quiz_type,
        "section_count" => self.section_count
      }
      if not self.site.nil?
        result["site"] = self.site.serialize(:summary)
      end
      result
    end

    def summary_serialization
      result = {
        "id" => self.id,
        "title" => self.title,
        "site_id" => nil,
        "type" => self.quiz_type
      }
      if not self.site.nil?
        result["site_id"] = self.site.id
      end
      result
    end

    def site_summary_serialization
      {
        "id" => self.id,
        "title" => self.title
      }
    end

    def dbrow_serialization
      {
        "dbrow" => self.dbrow
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

    def quiz_type
      "pending"
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

    def quiz_type
      "published"
    end
  end

  class QuizSection < SakaiObject
    attr_reader :dbrow, :quiz, :sequence, :title, :description, :typeid, :status

    include ModProps
    created_by_key :createdby
    created_at_key :createddate
    modified_by_key :lastmodifiedby
    modified_at_key :lastmodifieddate

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:sectionid]
      @quiz = Quiz.find(dbrow[:assessmentid])
      @sequence = dbrow[:sequence]
      @title = dbrow[:title]
      @description = dbrow[:description]
      @typeid = dbrow[:typeid]
      @status = dbrow[:status]
    end

    def self.find(id)
      quiz = nil
      begin
        quiz = PendingQuizSection.find(id)
      rescue ObjectNotFoundException
        begin
          quiz = PublishedQuizSection.find(id)
        rescue ObjectNotFoundException
          raise ObjectNotFoundException(QuizSection, id)
        end
      end
      quiz
    end

    def self.query_by_quiz_id(quiz_id)
      table = if Quiz.find(quiz_id).quiz_type == "pending"
                :sam_section_t
              else
                :sam_publishedsection_t
              end
      DB.connect[table].where(:assessmentid => quiz_id).order(:sequence)
    end

    def self.find_by_quiz_id(quiz_id)
      section_class = if Quiz.find(quiz_id).quiz_type == "pending"
                        PendingQuizSection
                      else
                        PublishedQuizSection
                      end

      QuizSection.query_by_quiz_id(quiz_id).all.collect do |row|
        results << section_class.new(row)
      end
    end

    def self.count_by_quiz_id(quiz_id)
      QuizSection.query_by_quiz_id(quiz_id).count
    end
  end

  class PendingQuizSection < QuizSection
  end

  class PublishedQuizSection < QuizSection
  end

  class QuizItem < SakaiObject
  end

  class PendingQuizItem < QuizItem
  end

  class PublishedQuizItem < QuizItem
  end
end

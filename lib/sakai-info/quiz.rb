# sakai-info/quiz.rb
#   SakaiInfo::Quiz library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-28 daveadams@gmail.com
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

    def sections
      @sections ||= QuizSection.find_by_quiz_id(@id)
    end

    def default_serialization
      result = {
        "id" => self.id,
        "title" => self.title,
        "site" => nil,
        "type" => self.quiz_type,
        "section_count" => self.section_count,
        "attempt_count" => nil
      }
      if not self.site.nil?
        result["site"] = self.site.serialize(:summary)
      end
      if self.respond_to? :attempt_count
        result["attempt_count"] = self.attempt_count
      else
        result.delete("attempt_count")
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

    def sections_serialization
      {
        "sections" => self.sections.collect{|s|s.serialize(:quiz_summary)}
      }
    end

    def self.all_serializations
      [:default, :sections]
    end
  end

  class PendingQuiz < Quiz
    @@cache = {}
    def self.find(id)
      id = id.to_s
      if @@cache[id].nil?
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
      id = id.to_s
      if @@cache[id].nil?
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

    def attempt_count
      @attempt_count ||= QuizAttempt.count_by_quiz_id(self.id)
    end

    def attempts
      @attempts ||= QuizAttempt.find_by_quiz_id(self.id)
    end

    def attempts_serialization
      {
        "attempts" => self.attempts.collect { |a| a.serialize(:quiz_summary) }
      }
    end

    def self.all_serializations
      [:default, :sections, :attempts]
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

    @@cache = {}
    def self.find(id)
      id = id.to_s
      if @@cache[id].nil?
        begin
          @@cache[id] = PendingQuizSection.find(id)
        rescue ObjectNotFoundException
          begin
            @@cache[id] = PublishedQuizSection.find(id)
          rescue ObjectNotFoundException
            raise ObjectNotFoundException.new(QuizSection, id)
          end
        end
      end
      @@cache[id]
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
        section_class.new(row)
      end
    end

    def self.count_by_quiz_id(quiz_id)
      QuizSection.query_by_quiz_id(quiz_id).count
    end

    def section_type
      nil
    end

    def item_count
      @item_count ||= QuizItem.count_by_section_id(@id)
    end

    def items
      @items ||= QuizItem.find_by_section_id(@id)
    end

    def default_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "quiz" => self.quiz.serialize(:summary),
        "sequence" => self.sequence,
        "item_count" => self.item_count,
        "description" => self.description,
        "type" => self.section_type,
        "typeid" => self.typeid,
        "status" => self.status
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "quiz_id" => self.quiz.id,
        "sequence" => self.sequence
      }
    end

    def quiz_summary_serialization
      result = summary_serialization
      result.delete("quiz_id")
      result
    end

    def items_serialization
      {
        "items" => self.items.collect{|i|i.serialize(:summary)}
      }
    end

    def self.all_serializations
      [:default, :items, :mod]
    end
  end

  class PendingQuizSection < QuizSection
    @@cache = {}
    def self.find(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect[:sam_section_t].where(:sectionid => id).first
        if row.nil?
          raise ObjectNotFoundException.new(PendingQuizSection, id)
        end

        @@cache[id] = PendingQuizSection.new(row)
      end
      @@cache[id]
    end

    def section_type
      "pending"
    end
  end

  class PublishedQuizSection < QuizSection
    @@cache = {}
    def self.find(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect[:sam_publishedsection_t].where(:sectionid => id).first
        if row.nil?
          raise ObjectNotFoundException.new(PublishedQuizSection, id)
        end

        @@cache[id] = PublishedQuizSection.new(row)
      end
      @@cache[id]
    end

    def section_type
      "published"
    end
  end

  class QuizItem < SakaiObject
    attr_reader :dbrow, :section, :quiz, :sequence, :typeid

    include ModProps
    created_by_key :createdby
    created_at_key :createddate
    modified_by_key :lastmodifiedby
    modified_at_key :lastmodifieddate

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:itemid]
      @section = QuizSection.find(dbrow[:sectionid])
      @quiz = @section.quiz
      @sequence = dbrow[:sequence]
      @typeid = dbrow[:typeid]
    end

    @@cache = {}
    def self.find(id)
      id = id.to_s
      if @@cache[id].nil?
        begin
          @@cache[id] = PendingQuizItem.find(id)
        rescue ObjectNotFoundException
          begin
            @@cache[id] = PublishedQuizItem.find(id)
          rescue ObjectNotFoundException
            raise ObjectNotFoundException.new(QuizItem, id)
          end
        end
      end
      @@cache[id]
    end

    def self.table_name_for_type(type)
      if type == "pending"
        :sam_item_t
      else
        :sam_publisheditem_t
      end
    end

    def self.class_for_type(type)
      if type == "pending"
        PendingQuizItem
      else
        PublishedQuizItem
      end
    end

    def self.query_by_section_id(section_id)
      table = QuizItem.table_name_for_type(QuizSection.find(section_id).section_type)
      DB.connect[table].where(:sectionid => section_id).order(:sequence)
    end

    def self.count_by_section_id(section_id)
      QuizItem.query_by_section_id(section_id).count
    end

    def self.find_by_section_id(section_id)
      item_class = QuizItem.class_for_type(QuizSection.find(section_id).section_type)
      QuizItem.query_by_section_id(section_id).all.collect do |row|
        item_class.new(row)
      end
    end

    def self.query_by_quiz_id(quiz_id)
      table = QuizItem.table_name_for_type(Quiz.find(quiz_id).quiz_type)
      DB.connect[table].
        where(:sectionid => Quiz.find(quiz_id).sections.collect{|s|s.id})
    end

    def self.count_by_quiz_id(quiz_id)
      QuizItem.query_by_quiz_id(quiz_id).count
    end

    def self.find_by_quiz_id(quiz_id)
      item_class = QuizItem.class_for_type(Quiz.find(quiz_id).quiz_type)
      QuizItem.query_by_quiz_id(quiz_id).all.collect do |row|
        item_class.new(row)
      end
    end

    def item_type
      nil
    end

    def default_serialization
      {
        "id" => self.id,
        "quiz" => self.quiz.serialize(:summary),
        "section" => self.section.serialize(:summary),
        "sequence" => self.sequence,
        "type" => self.item_type,
        "typeid" => self.typeid
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "quiz_id" => self.quiz.id,
        "section_id" => self.section.id
      }
    end

    def self.all_serializations
      [:default, :mod]
    end
  end

  class PendingQuizItem < QuizItem
    @@cache = {}
    def self.find(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect[:sam_item_t].where(:itemid => id).first
        if row.nil?
          raise ObjectNotFoundException.new(PendingQuizItem, id)
        end

        @@cache[id] = PendingQuizItem.new(row)
      end
      @@cache[id]
    end

    def item_type
      "pending"
    end
  end

  class PublishedQuizItem < QuizItem
    @@cache = {}
    def self.find(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect[:sam_publisheditem_t].where(:itemid => id).first
        if row.nil?
          raise ObjectNotFoundException.new(PublishedQuizItem, id)
        end

        @@cache[id] = PublishedQuizItem.new(row)
      end
      @@cache[id]
    end

    def item_type
      "published"
    end
  end

  # class QuizItemAttachment < SakaiObject
  # end

  # class PendingQuizItemAttachment < QuizItemAttachment
  # end

  # class PublishedQuizItemAttachment < QuizItemAttachment
  # end

  class QuizAttempt < SakaiObject
    attr_reader :dbrow, :submitted_at, :total_auto_score, :status, :attempted_at
    attr_reader :time_elapsed, :comments, :user_id, :quiz_id

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:assessmentgradingid]
      @submitted_at = dbrow[:submitteddate]
      @user_id = dbrow[:agentid]
      @quiz_id = dbrow[:publishedassessmentid]
      @total_auto_score = dbrow[:totalautoscore]
      @status = dbrow[:status]
      @attempted_at = dbrow[:attempted_at]
      @time_elapsed = dbrow[:timeelapsed]
      @is_auto_submitted = dbrow[:is_auto_submitted]
      @is_late = dbrow[:islate]
      @comments = dbrow[:comments]
    end

    @@cache = {}
    def self.find(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect[:sam_assessmentgrading_t].where(:assessmentgradingid => id).first
        if row.nil?
          raise ObjectNotFoundException.new(QuizAttempt, id)
        end

        @@cache[id] = QuizAttempt.new(row)
      end
      @@cache[id]
    end

    def self.query_by_quiz_id(quiz_id)
      DB.connect[:sam_assessmentgrading_t].where(:publishedassessmentid => quiz_id)
    end

    def self.count_by_quiz_id(quiz_id)
      QuizAttempt.query_by_quiz_id(quiz_id).count
    end

    def self.find_by_quiz_id(quiz_id)
      QuizAttempt.query_by_quiz_id(quiz_id).
        all.collect { |row| QuizAttempt.new(row) }
    end

    def items
      @items ||= QuizAttemptItem.find_by_attempt_id(self.id)
    end

    def item_count
      @item_count ||= QuizAttemptItem.count_by_attempt_id(self.id)
    end

    def user
      @user ||= User.find(@user_id)
    end

    def quiz
      @quiz ||= PublishedQuiz.find(@quiz_id)
    end

    def auto_submitted?
      @is_auto_submitted == 1
    end

    def late?
      @is_late == 1
    end

    def default_serialization
      {
        "id" => self.id,
        "user" => self.user.serialize(:summary),
        "quiz" => self.quiz.serialize(:summary),
        "item_count" => self.item_count,
        "submitted_at" => self.submitted_at,
        "is_auto_submitted" => self.auto_submitted?,
        "is_late" => self.late?,
        "status" => self.status,
        "total_auto_score" => self.total_auto_score
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "eid" => User.get_eid(self.user_id),
        "quiz_id" => self.quiz_id,
        "status" => self.status
      }
    end

    def quiz_summary_serialization
      {
        "id" => self.id,
        "eid" => User.get_eid(self.user_id),
        "status" => self.status
      }
    end

    def items_serialization
      {
        "items" => self.items.collect { |i| i.serialize(:attempt_summary) }
      }
    end

    def self.all_serializations
      [:default, :items]
    end
  end

  class QuizAttemptItem < SakaiObject
    attr_reader :dbrow, :submitted_at, :answer, :user_id, :item_id, :attempt_id

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:itemgradingid]
      @submitted_at = dbrow[:submitteddate]
      @user_id = dbrow[:agentid]
      @attempt_id = dbrow[:assessmentgradingid]
      @item_id = dbrow[:publisheditemid]
      @answer = dbrow[:answertext]
    end

    def user
      @user ||= User.find(@user_id)
    end

    def attempt
      @attempt ||= QuizAttempt.find(@attempt_id)
    end

    def item
      @item ||= PublishedQuizItem.find(@item_id)
    end

    @@cache = {}
    def self.find(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect[:sam_itemgrading_t].where(:itemgradingid => id).first
        if row.nil?
          raise ObjectNotFoundException.new(QuizAttemptItem, id)
        end

        @@cache[id] = QuizAttemptItem.new(row)
      end
      @@cache[id]
    end

    def self.query_by_attempt_id(attempt_id)
      DB.connect[:sam_itemgrading_t].where(:assessmentgradingid => attempt_id)
    end

    def self.count_by_attempt_id(attempt_id)
      QuizAttemptItem.query_by_attempt_id(attempt_id).count
    end

    def self.find_by_attempt_id(attempt_id)
      QuizAttemptItem.query_by_attempt_id(attempt_id).
        all.collect { |row| QuizAttemptItem.new(row) }
    end

    def attachments
      @attachments ||=
        QuizAttemptItemAttachment.find_by_quiz_attempt_item_id(self.id)
    end

    def default_serialization
      {
        "id" => self.id,
        "user" => self.user.serialize(:summary),
        "attempt" => self.attempt.serialize(:summary),
        "item" => self.item.serialize(:summary),
        "answer" => self.answer,
        "attachment_count" => self.attachments.length
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "eid" => User.get_eid(self.user_id),
        "attempt_id" => self.attempt_id,
        "item_id" => self.item_id
      }
    end

    def attempt_summary_serialization
      {
        "id" => self.id,
        "item_id" => self.item_id
      }
    end

    def attachments_serialization
      {
        "attachments" => self.attachments.collect{|a|a.serialize(:attempt_item_summary)}
      }
    end

    def self.all_serializations
      [:default, :attachments]
    end
  end

  class QuizAttemptItemAttachment < SakaiObject
    attr_reader :dbrow, :status, :filepath, :filename, :filesize, :mimetype
    attr_reader :description, :quiz_attempt_item_id

    include ModProps
    created_by_key :createdby
    created_at_key :createddate
    modified_by_key :lastmodifiedby
    modified_at_key :lastmodifieddate

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:mediaid]
      @quiz_attempt_item_id = dbrow[:itemgradingid]
      @status = dbrow[:status]
      @filepath = dbrow[:location]
      @filename = dbrow[:filename]
      @filesize = dbrow[:filesize]
      @mimetype = dbrow[:mimetype]
      @description = dbrow[:description]
    end

    def quiz_attempt_item
      @quiz_attempt_item ||= QuizAttemptItem.find(@quiz_attempt_item_id)
    end

    def self.find_by_quiz_attempt_item_id(quiz_attempt_item_id)
      DB.connect[:sam_media_t].where(:itemgradingid => quiz_attempt_item_id).
        all.collect { |row| QuizAttemptItemAttachment.new(row) }
    end

    @@cache = {}
    def self.find(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect[:sam_media_t].where(:mediaid => id).first
        if row.nil?
          raise ObjectNotFoundException.new(QuizAttemptItemAttachment, id)
        end

        @@cache[id] = QuizAttemptItemAttachment.new(row)
      end
      @@cache[id]
    end

    def default_serialization
      {
        "id" => self.id,
        "filename" => self.filename,
        "mimetype" => self.mimetype,
        "filesize" => self.filesize,
        "status" => self.status,
        "quiz_attempt_item" => self.quiz_attempt_item.serialize(:summary)
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "filename" => self.filename,
        "quiz_attempt_item_id" => self.quiz_attempt_item_id
      }
    end

    def attempt_item_summary_serialization
      {
        "id" => self.id,
        "filename" => self.filename
      }
    end
  end
end

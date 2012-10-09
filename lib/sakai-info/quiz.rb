# sakai-info/quiz.rb
#   SakaiInfo::Quiz library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-10-09 daveadams@gmail.com
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

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

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

    # possible statuses
    INACTIVE = 0
    ACTIVE = 1
    DELETED = 2 # aka 'DEAD' in the Scholar source
    RETRACTED_FOR_EDITING = 3
    def status
      case @dbrow[:status].to_i
      when INACTIVE then "inactive"
      when ACTIVE then "active"
      when DELETED then "deleted"
      when RETRACTED_FOR_EDITING then "retracted for editing"
      else "unknown status '#{@dbrow[:status].to_i}'"
      end
    end

    def section_count
      @section_count ||= self.section_class.count_by_quiz_id(@id)
    end

    def sections
      @sections ||= self.section_class.find_by_quiz_id(@id)
    end

    def item_count
      @item_count ||= self.item_class.count_by_quiz_id(self.id)
    end

    def items
      @items ||= self.item_class.find_by_quiz_id(self.id)
    end

    def access_control
      @access_control ||= self.access_control_class.find(self.id)
    end

    def default_serialization
      result = {
        "id" => self.id,
        "title" => self.title,
        "site" => nil,
        "status" => self.status,
        "type" => self.quiz_type,
        "section_count" => self.section_count,
        "item_count" => self.item_count,
        "attempt_count" => nil,
        "access_control" => self.access_control.serialize(:quiz_summary)
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
        "status" => self.status,
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
        "title" => self.title,
        "status" => self.status,
      }
    end

    def access_control_summary_serialization
      result = self.summary_serialization
      result.delete("id")
      result
    end

    def sections_serialization
      {
        "sections" => self.sections.collect{|s|s.serialize(:quiz_summary)}
      }
    end

    def items_serialization
      {
        "items" => self.items.collect { |i| i.serialize(:quiz_summary) }
      }
    end

    def self.all_serializations
      [
       :default,
       :sections,
       :items,
      ]
    end
  end

  class PendingQuiz < Quiz
    def self.clear_cache
      @@cache = {}
    end
    clear_cache

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
      PendingQuiz.query_by_site_id(site_id).all.collect do |row|
        @@cache[row[:id]] = PendingQuiz.new(row, site_id)
      end
    end

    def self.count_by_site_id(site_id)
      PendingQuiz.query_by_site_id(site_id).count
    end

    def self.find_ids_by_site_id(site_id)
      PendingQuiz.query_by_site_id(site_id).select(:id).all.collect { |row| row[:id] }
    end

    def quiz_type
      "pending"
    end

    def section_class
      PendingQuizSection
    end

    def item_class
      PendingQuizItem
    end

    def access_control_class
      PendingQuizAccessControl
    end
  end

  class PublishedQuiz < Quiz
    def self.clear_cache
      @@cache = {}
    end
    clear_cache

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
      PublishedQuiz.query_by_site_id(site_id).all.collect do |row|
        @@cache[row[:id]] = PublishedQuiz.new(row, site_id)
      end
    end

    def self.count_by_site_id(site_id)
      PublishedQuiz.query_by_site_id(site_id).count
    end

    def self.find_ids_by_site_id(site_id)
      PublishedQuiz.query_by_site_id(site_id).select(:id).all.collect { |row| row[:id] }
    end

    def user_attempts(user_id)
      QuizAttempt.find_by_user_id_and_quiz_id(user_id, self.id)
    end

    def quiz_type
      "published"
    end

    def section_class
      PublishedQuizSection
    end

    def item_class
      PublishedQuizItem
    end

    def access_control_class
      PublishedQuizAccessControl
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
      [
       :default,
       :sections,
       :items,
       :attempts,
      ]
    end
  end

  class QuizSection < SakaiObject
    attr_reader :dbrow, :quiz, :sequence, :title, :description, :typeid, :status

    include ModProps
    created_by_key :createdby
    created_at_key :createddate
    modified_by_key :lastmodifiedby
    modified_at_key :lastmodifieddate

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

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
      section_class = Quiz.find(quiz_id).section_class
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
      @item_count ||= QuizItem.count_by_section_id(self.id)
    end

    def items
      @items ||= QuizItem.find_by_section_id(self.id)
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
        "items" => self.items.collect{|i|i.serialize(:section_summary)}
      }
    end

    def self.all_serializations
      [:default, :items, :mod]
    end
  end

  class PendingQuizSection < QuizSection
    def self.clear_cache
      @@cache = {}
    end
    clear_cache

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
    def self.clear_cache
      @@cache = {}
    end
    clear_cache

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

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:itemid]
      @section = QuizSection.find(dbrow[:sectionid])
      @quiz = @section.quiz
      @sequence = dbrow[:sequence]
      @typeid = dbrow[:typeid]
    end

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
      QuizItem.query_by_quiz_id(quiz_id).order(:sequence).all.collect do |row|
        item_class.new(row)
      end.sort { |a,b| if a.section.sequence == b.section.sequence
                         a.sequence <=> b.sequence
                       else
                         a.section.sequence <=> b.section.sequence
                       end }
    end

    def item_type
      nil
    end

    def itemtext_table
      nil
    end

    def texts
      if self.itemtext_table.nil?
        return []
      end

      DB.connect[self.itemtext_table].
        select(:text).
        where(:itemid => self.id).
        order(:sequence).all.
        collect { |row| row[:text].read }
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

    def quiz_summary_serialization
      {
        "id" => self.id,
        "section" => self.section.sequence,
        "sequence" => self.sequence,
      }
    end

    def section_summary_serialization
      {
        "id" => self.id,
        "sequence" => self.sequence,
      }
    end

    def texts_serialization
      {
        "texts" => self.texts
      }
    end

    def self.all_serializations
      [
       :default,
       :mod,
       :texts
      ]
    end
  end

  class PendingQuizItem < QuizItem
    def self.clear_cache
      @@cache = {}
    end
    clear_cache

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

    def itemtext_table
      :sam_itemtext_t
    end
  end

  class PublishedQuizItem < QuizItem
    def self.clear_cache
      @@cache = {}
    end
    clear_cache

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

    def itemtext_table
      :sam_publisheditemtext_t
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

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

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

    def self.query_by_user_id_and_quiz_id(user_id, quiz_id)
      DB.connect[:sam_assessmentgrading_t].where(:publishedassessmentid => quiz_id, :agentid => user_id)
    end

    def self.find_by_user_id_and_quiz_id(user_id, quiz_id)
      QuizAttempt.query_by_user_id_and_quiz_id(user_id, quiz_id).
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

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

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
        "attachment_count" => self.attachments.length,
        "submitted_at" => self.submitted_at,
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "eid" => User.get_eid(self.user_id),
        "attempt_id" => self.attempt_id,
        "item_id" => self.item_id,
        "submitted_at" => self.submitted_at,
      }
    end

    def attempt_summary_serialization
      {
        "id" => self.id,
        "item_id" => self.item_id,
        "submitted_at" => self.submitted_at,
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

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

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

  class QuizAccessControl < SakaiObject
    attr_reader :id, :dbrow

    def initialize(dbrow)
      @dbrow = dbrow
      @id = dbrow[:assessmentid]
    end

    def unlimited_submissions?
      @dbrow[:unlimitedsubmissions] == 1
    end

    def submissions_allowed
      @dbrow[:submissionsallowed]
    end

    def submissions_saved
      @dbrow[:submissionssaved] == 1
    end

    def question_layout
      case @dbrow[:assessmentformat]
      when 1
        "One question per page"
      when 2
        "One part per page"
      when 3
        "Single page quiz"
      else
        @dbrow[:assessmentformat]
      end
    end

    def late_handling
      case @dbrow[:latehandling]
      when 1
        "Late submissions accepted"
      when 2
        "Late submissions NOT accepted"
      else
        @dbrow[:latehandling]
      end
    end

    def item_navigation
      case @dbrow[:itemnavigation]
      when 1
        "Linear"
      when 2
        "Random"
      else
        @dbrow[:itemnavigation]
      end
    end

    def item_numbering
      case @dbrow[:itemnumbering]
      when 1
        "Continuous through parts"
      when 2
        "Restart numbering at each part"
      else
        @dbrow[:itemnumbering]
      end
    end

    def submission_message
      @dbrow[:submissionmessage]
    end

    def release_to
      @dbrow[:releaseto]
    end

    def username
      @dbrow[:username]
    end

    def password
      @dbrow[:password]
    end

    def final_page_url
      @dbrow[:finalpageurl]
    end

    def mark_for_review_allowed?
      @dbrow[:markforreview] == 1
    end

    def authenticated?
      not (self.username.nil? and self.password.nil?)
    end

    def time_limit
      @dbrow[:timelimit]
    end

    def timed?
      @dbrow[:timelimit] > 0
    end

    def automatic_submission?
      @dbrow[:autosubmit] == 1
    end

    def start_date
      if @dbrow[:startdate].nil?
        nil
      else
        @dbrow[:startdate].strftime("%Y-%m-%d %H:%M:%S")
      end
    end

    def due_date
      if @dbrow[:duedate].nil?
        nil
      else
        @dbrow[:duedate].strftime("%Y-%m-%d %H:%M:%S")
      end
    end

    def retract_date
      if @dbrow[:retractdate].nil?
        nil
      else
        @dbrow[:retractdate].strftime("%Y-%m-%d %H:%M:%S")
      end
    end

    def feedback_date
      if @dbrow[:feedbackdate].nil?
        nil
      else
        @dbrow[:feedbackdate].strftime("%Y-%m-%d %H:%M:%S")
      end
    end

    def score_date
      if @dbrow[:scoredate].nil?
        nil
      else
        @dbrow[:scoredate].strftime("%Y-%m-%d %H:%M:%S")
      end
    end

    def default_serialization
      result = {
        "id" => self.id,
        "quiz" => self.quiz.serialize(:access_control_summary),
        "unlimited_submissions" => self.unlimited_submissions?,
        "submissions_allowed" => self.submissions_allowed,
        "timed" => self.timed?,
        "time_limit" => self.time_limit,
        "question_layout" => self.question_layout,
        "late_handling" => self.late_handling,
        "item_navigation" => self.item_navigation,
        "item_numbering" => self.item_numbering,
        "release_to" => self.release_to,
        "authenticated" => self.authenticated?,
        "automatic_submission" => self.automatic_submission?,
        "mark_for_review_allowed" => self.mark_for_review_allowed?,
      }
      if not self.timed?
        result.delete("time_limit")
      end
      if self.unlimited_submissions?
        result.delete("submissions_allowed")
      end
      %w(username start_date due_date score_date retract_date feedback_date submission_message final_page_url).each do |field_name|
        value = self.method(field_name.to_sym).call
        if not value.nil?
          result[field_name] = value
        end
      end
      result
    end

    def quiz_summary_serialization
      result = default_serialization
      result.delete("quiz")
      result.delete("id")
      result
    end

    def summary_serialization
      {
        "id" => self.id,
      }
    end
  end

  class PendingQuizAccessControl < QuizAccessControl
    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def self.find(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect[:sam_assessaccesscontrol_t].where(:assessmentid => id.to_i).first
        if row.nil?
          raise ObjectNotFoundException.new(PendingQuizAccessControl, id)
        end

        @@cache[id] = PendingQuizAccessControl.new(row)
      end
      @@cache[id]
    end

    def quiz
      @quiz ||= PendingQuiz.find(self.id)
    end
  end

  class PublishedQuizAccessControl < QuizAccessControl
    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def self.find(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect[:sam_publishedaccesscontrol_t].where(:assessmentid => id.to_i).first
        if row.nil?
          raise ObjectNotFoundException.new(PublishedQuizAccessControl, id)
        end

        @@cache[id] = PublishedQuizAccessControl.new(row)
      end
      @@cache[id]
    end

    def quiz
      @quiz ||= PublishedQuiz.find(self.id)
    end
  end
end

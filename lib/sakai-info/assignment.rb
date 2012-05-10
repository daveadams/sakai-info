# sakai-info/assignment.rb
#   SakaiInfo::Assignment library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-05-10 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Assignment < SakaiXMLEntity
    attr_reader :dbrow, :site_id

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def self.find(id)
      if @@cache[id].nil?
        xml = ""
        row = DB.connect[:assignment_assignment].where(:assignment_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(Assignment, id)
        end
        @@cache[id] = Assignment.new(row)
      end
      @@cache[id]
    end

    # raw data constructor
    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:assignment_id]
      @site_id = dbrow[:context]

      parse_xml
    end

    # set lookup
    def self.query_by_site_id(site_id)
      DB.connect[:assignment_assignment].where(:context => site_id)
    end

    def self.find_by_site_id(site_id)
      Assignment.query_by_site_id(site_id).
        all.collect { |row| Assignment.new(row) }
    end

    def self.count_by_site_id(site_id)
      Assignment.query_by_site_id(site_id).count
    end

    # getters
    def title
      @attributes["title"]
    end

    def site
      @site ||= Site.find(self.site_id)
    end

    def submissions
      @submissions ||= AssignmentSubmission.find_by_assignment_id(self.id)
    end

    def submission_count
      @submission_count ||= AssignmentSubmission.count_by_assignment_id(self.id)
    end

    # yaml/json serialization
    def default_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "site" => self.site.serialize(:summary),
        "submission_count" => self.submission_count
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "submission_count" => self.submission_count
      }
    end

    def submissions_serialization
      {
        "submissions" => self.submissions.collect{|s|s.serialize(:assignment_summary)}
      }
    end
  end

  class AssignmentSubmission < SakaiXMLEntity
    attr_reader :dbrow, :assignment_id, :submitter_id

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:submission_id]
      @assignment_id = dbrow[:context]
      @submitter_id = dbrow[:submitter_id]
      @is_submitted = (dbrow[:submitted] == "true")
      @is_graded = (dbrow[:graded] == "true")

      parse_xml
    end

    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:assignment_submission].where(:submission_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(AssignmentSubmission, id)
        end

        @@cache[id] = AssignmentSubmission.new(row)
      end
      @@cache[id]
    end

    def submitter
      @submitter ||= User.find(self.submitter_id)
    end

    def assignment
      @assignment ||= Assignment.find(self.assignment_id)
    end

    def submitted?
      ( self.created_by_id == self.submitter_id && @is_submitted ) || false
    end

    def graded?
      @is_graded || false
    end

    def submitted_at
      @submitted_at ||= Util.format_entity_date(@attributes["datesubmitted"])
    end

    def self.query_by_assignment_id(assignment_id)
      DB.connect[:assignment_submission].where(:context => assignment_id)
    end

    def self.find_by_assignment_id(assignment_id)
      AssignmentSubmission.query_by_assignment_id(assignment_id).
        all.collect { |row| AssignmentSubmission.new(row) }
    end

    def self.count_by_assignment_id(assignment_id)
      AssignmentSubmission.query_by_assignment_id(assignment_id).count
    end

    def self.query_by_user_id(user_id)
      DB.connect[:assignment_submission].where(:submitter_id => user_id)
    end

    def self.find_by_user_id(user_id)
      AssignmentSubmission.query_by_user_id(user_id).
        all.collect { |row| AssignmentSubmission.new(row) }
    end

    def self.count_by_user_id(user_id)
      AssignmentSubmission.query_by_user_id(user_id).count
    end

    # yaml/json serialization
    def default_serialization
      result = {
        "id" => self.id,
        "assignment" => self.assignment.serialize(:summary),
        "submitter" => self.submitter.serialize(:summary),
        "is_submitted" => self.submitted?,
        "submitted_at" => self.submitted_at,
        "is_graded" => self.graded?,
      }
      if not self.submitted?
        result.delete("submitted_at")
        result.delete("is_graded")
      end
      result
    end

    def summary_serialization
      {
        "id" => self.id,
        "assignment_id" => self.assignment_id,
        "submitter" => User.get_eid(self.submitter_id),
        "is_submitted" => self.submitted?
      }
    end

    def assignment_summary_serialization
      {
        "id" => self.id,
        "submitter" => User.get_eid(self.submitter_id),
        "is_submitted" => self.submitted?
      }
    end
  end

  class AssignmentContent < SakaiXMLEntity
    attr_reader :owner

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(id, owner, xml)
      @id = id
      @owner = owner
      @xml = xml
      parse_xml
    end

    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:assignment_content].where(:content_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(AssignmentContent, id)
        end
        xml = ""
        REXML::Document.new(row[:xml].read).write(xml, 2)
        @@cache[id] = AssignmentContent.new(id, row[:context], xml)
      end
      @@cache[id]
    end

    def self.find_by_user_id(user_id)
      contents = []
      DB.connect[:assignment_content].where(:context => user_id).all.each do |row|
        id = row[:content_id]
        context = row[:context]
        xml = ""
        REXML::Document.new(row[:xml].read).write(xml, 2)
        contents << AssignmentContent.new(id, context, xml)
      end
      return contents
    end

    def self.count_by_user_id(user_id)
      DB.connect[:assignment_content].where(:context => user_id).count
    end

    # getters
    def title
      @attributes["title"]
    end
  end
end

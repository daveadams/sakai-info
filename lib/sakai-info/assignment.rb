# sakai-info/assignment.rb
#   SakaiInfo::Assignment library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-29 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Assignment < SakaiXMLEntity
    attr_reader :dbrow, :site_id

    @@cache = {}
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
        "submissions" => self.submission_count
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "created_by" => User.get_eid(self.created_by_id),
        "submissions" => self.submission_count
      }
    end

    def submissions_serialization
      {
        "submissions" => self.submissions.collect{|s|s.serialize(:assignment_summary)}
      }
    end
  end

  class AssignmentSubmission < SakaiXMLEntity
    attr_reader :assignment, :submitter

    def initialize(id, assignment, xml, submitter, submitted, graded)
      @id = id
      @assignment = assignment
      @xml = xml
      @submitter = submitter
      @submitted = submitted
      @graded = graded
      parse_xml
    end

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:assignment_submission].where(:submission_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(AssignmentSubmission, id)
        end

        assignment = Assignment.find(row[:context])
        REXML::Document.new(row[:xml].read).write(xml, 2)
        submitter = User.find(row[:submitter_id])
        submitted = (row[:submitted] == "true")
        graded = (row[:graded] == "true")

        @@cache[id] = AssignmentSubmission.new(id, assignment, xml, submitter, submitted, graded)
      end
      @@cache[id]
    end

    def submitted?
      ( created_by.eid == @submitter.eid && @submitted ) || false
    end

    def graded?
      @graded || false
    end

    def submitted_at
      @submitted_at ||= format_entity_date(@attributes["datesubmitted"])
    end

    def self.query_by_assignment_id(assignment_id)
      DB.connect[:assignment_submission].where(:context => assignment_id)
    end

    def self.find_by_assignment_id(assignment_id)
      submissions = []
      assignment = Assignment.find(assignment_id)
      DB.connect[:assignment_submission].filter(:context => assignment_id).all.each do |row|
        id = row[:submission_id]
        xml = ""
        REXML::Document.new(row[:xml].read).write(xml, 2)
        submitter = User.find(row[:submitter_id])
        submitted = (row[:submitted] == "true")
        graded = (row[:graded] == "true")
        submissions << AssignmentSubmission.new(id, assignment, xml, submitter, submitted, graded)
      end
      return submissions
    end

    def self.count_by_assignment_id(assignment_id)
      AssignmentSubmission.query_by_assignment_id(assignment_id).count
    end

    def self.query_by_user_id(user_id)
      DB.connect[:assignment_submission].where(:submitter_id => user_id)
    end

    def self.find_by_user_id(user_id)
      submissions = []
      submitter = User.find(user_id)
      DB.connect[:assignment_submission].filter(:submitter_id => user_id).all.each do |row|
        id = row[:submission_id]
        assignment = Assignment.find(row[:context])
        xml = ""
        REXML::Document.new(row[:xml].read).write(xml, 2)
        submitted = (row[:submitted] == "true")
        graded = (row[:graded] == "true")
        submissions << AssignmentSubmission.new(id, assignment, xml, submitter, submitted, graded)
      end
      return submissions
    end

    def self.count_by_user_id(user_id)
      DB.connect[:assignment_submission].filter(:submitter_id => user_id).count
    end

    # yaml/json serialization
    def default_serialization
      {
        "id" => self.id,
        "assignment" => self.assignment.serialize(:summary),
        "submitter" => self.submitter.serialize(:summary),
        "submitted" => self.submitted?,
        "submitted_at" => self.submitted_at,
        "graded" => self.graded?,
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "assignment_id" => self.assignment.id,
        "submitter" => self.submitter.eid,
        "submitted" => self.submitted?
      }
    end

    def assignment_summary_serialization
      {
        "id" => self.id,
        "submitter" => self.submitter.eid,
        "submitted" => self.submitted?
      }
    end
  end

  class AssignmentContent < SakaiXMLEntity
    attr_reader :owner

    def initialize(id, owner, xml)
      @id = id
      @owner = owner
      @xml = xml
      parse_xml
    end

    @@cache = {}
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

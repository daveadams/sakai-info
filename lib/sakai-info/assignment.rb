# sakai-info/assignment.rb
#   SakaiInfo::Assignment library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-24 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Assignment < SakaiXMLEntity
    attr_reader :site

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        site = nil
        xml = ""
        DB.connect.exec("select context, xml from assignment_assignment " +
                      "where assignment_id = :id", id) do |row|
          site = Site.find(row[0])
          REXML::Document.new(row[1].read).write(xml, 2)
        end
        if site.nil?
          raise ObjectNotFoundException.new(Assignment, id)
        end
        @@cache[id] = Assignment.new(id, site, xml)
      end
      @@cache[id]
    end

    # raw data constructor
    def initialize(id, site, xml)
      @id = id
      @site = site
      @xml = xml
      parse_xml
    end

    # set lookup
    def self.find_by_site_id(site_id)
      assignments = []
      DB.connect.exec("select assignment_id, context, xml from assignment_assignment " +
                      "where context = :site_id", site_id) do |row|
        id = row[0]
        site = Site.find(row[1])
        xml = ""
        REXML::Document.new(row[2].read).write(xml, 2)
        assignments << Assignment.new(id, site, xml)
      end
      return assignments
    end

    def self.count_by_site_id(site_id)
      DB.connect[:assignment_assignment].filter(:context => site_id).count
    end

    # getters
    def title
      @attributes["title"]
    end

    def submissions
      @submissions ||= AssignmentSubmission.find_by_assignment_id(@id)
    end

    def submission_count
      @submission_count ||= AssignmentSubmission.count_by_assignment_id(@id)
    end

    # yaml/json serialization
    def default_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "site" => self.site.serialize(:summary),
        "created_by" => self.created_by.eid,
        "created_at" => self.created_at,
        "submissions" => self.submission_count
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "created_by" => self.created_by.eid,
        "submissions" => self.submission_count
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
        assignment = submitter = submitted_at = submitted = graded = nil
        xml = ""
        DB.connect.exec("select context, xml, submitter_id, " +
                        "submitted, graded from assignment_submission " +
                        "where submission_id = :id", id) do |row|
          assignment = Assignment.find(row[0])
          xml = ""
          REXML::Document.new(row[1].read).write(xml, 2)
          submitter = User.find(row[2])
          submitted = (row[3] == "true")
          graded = (row[4] == "true")
        end
        if assignment.nil?
          raise ObjectNotFoundException.new(AssignmentSubmission, id)
        end
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

    def self.find_by_assignment_id(assignment_id)
      submissions = []
      DB.connect.exec("select submission_id, context, xml, submitter_id, " +
                      "submitted, graded from assignment_submission " +
                      "where context = :assignment_id", assignment_id) do |row|
        id = row[0]
        assignment = Assignment.find(row[1])
        xml = ""
        REXML::Document.new(row[2].read).write(xml, 2)
        submitter = User.find(row[3])
        submitted = (row[4] == "true")
        graded = (row[5] == "true")
        submissions << AssignmentSubmission.new(id, assignment, xml, submitter, submitted, graded)
      end
      return submissions
    end

    def self.count_by_assignment_id(assignment_id)
      submission_count = 0
      DB.connect.exec("select count(*) from assignment_submission " +
                      "where context = :assignment_id", assignment_id) do |row|
        submission_count = row[0].to_i
      end
      return submission_count
    end

    def self.find_by_user_id(user_id)
      submissions = []
      DB.connect.exec("select submission_id, context, xml, submitter_id, " +
                      "submitted, graded from assignment_submission " +
                      "where submitter_id = :user_id", user_id) do |row|
        id = row[0]
        assignment = Assignment.find(row[1])
        xml = ""
        REXML::Document.new(row[2].read).write(xml, 2)
        submitter = User.find(row[3])
        submitted = (row[4] == "true")
        graded = (row[5] == "true")
        submissions << AssignmentSubmission.new(id, assignment, xml, submitter, submitted, graded)
      end
      return submissions
    end

    def self.count_by_user_id(user_id)
      submission_count = 0
      DB.connect.exec("select count(*) from assignment_submission " +
                      "where submitter_id = :user_id", user_id) do |row|
        submission_count = row[0].to_i
      end
      return submission_count
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
        "created_by" => self.created_by.eid,
        "created_at" => self.created_at,
        "modified_by" => self.modified_by.eid,
        "modified_at" => self.modified_at
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
        context = nil
        xml = ""
        DB.connect.exec("select context, xml from assignment_content " +
                      "where content_id = :id", id) do |row|
          context = row[0]
          REXML::Document.new(row[1].read).write(xml, 2)
        end
        if context.nil?
          raise ObjectNotFoundException.new(AssignmentContent, id)
        end
        @@cache[id] = AssignmentContent.new(id, context, xml)
      end
      @@cache[id]
    end

    def self.find_by_user_id(user_id)
      contents = []
      DB.connect.exec("select content_id, context, xml from assignment_content " +
                      "where context = :user_id", user_id) do |row|
        id = row[0]
        context = row[1]
        xml = ""
        REXML::Document.new(row[2].read).write(xml, 2)
        contents << AssignmentContent.new(id, context, xml)
      end
      return contents
    end

    def self.count_by_user_id(user_id)
      content_count = 0
      DB.connect.exec("select count(*) from assignment_content " +
                      "where context = :user_id", user_id) do |row|
        content_count = row[0].to_i
      end
      content_count
    end

    # getters
    def title
      @attributes["title"]
    end
  end
end

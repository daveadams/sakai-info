# sakai-info/user.rb
#   SakaiInfo::User library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-17 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class User < SakaiObject
    attr_reader :eid, :name, :type
    attr_reader :created_by, :created_at, :modified_by, :modified_at

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        user_id = eid = nil
        DB.connect.exec("select user_id, eid from sakai_user_id_map " +
                        "where user_id=:user_id or eid=:eid", id, id) do |row|
          user_id = row[0]
          eid = row[1]
        end
        if user_id.nil? or eid.nil?
          raise ObjectNotFoundException.new(User, id)
        end

        DB.connect.exec("select first_name, last_name, type, " +
                        "to_char(createdon,'YYYY-MM-DD HH24:MI:SS'), " +
                        "to_char(modifiedon,'YYYY-MM-DD HH24:MI:SS') " +
                        "from sakai_user where user_id=:userid", user_id) do |row|
          first_name, last_name, type, created_at, modified_at = *row
          first_name ||= ""
          last_name ||= ""
          @@cache[eid] =
            @@cache[user_id] =
            User.new(user_id, eid, (first_name+' '+last_name), type, created_at, modified_at)
        end
      end
      @@cache[id]
    end

    def initialize(id, eid, name, type, created_at, modified_at)
      @id = id
      @eid = eid
      @name = name
      @type = type
      @created_at = created_at
      @modified_at = modified_at
      @properties = nil
    end

    def properties
      @properties ||= UserProperty.find_by_user_id(@id)
    end

    def workspace
      @workspace ||= Site.find("~" + @id)
    end

    def question_pools
      @question_pools ||= QuestionPool.find_by_user_id(@id)
    end

    def question_pool_count
      if @question_pools.nil?
        QuestionPool.count_by_user_id(@id)
      else
        @question_pools.length
      end
    end

    def assignment_submissions
      @assignment_submissions ||= AssignmentSubmission.find_by_user_id(@id)
    end

    def assignment_submission_count
      @assignment_submission_count ||= AssignmentSubmission.count_by_user_id(@id)
    end

    def assignment_contents
      @assignment_contents ||= AssignmentContent.find_by_user_id(@id)
    end

    def assignment_content_count
      @assignment_content_count ||= AssignmentContent.count_by_user_id(@id)
    end

    def membership
      @membership ||= SiteMembership.find_by_user_id(@id)
    end

    def site_count
      if @membership.nil?
        Site.count_by_user_id(@id)
      else
        @membership.length
      end
    end

    def preferences_xml
      if @preferences_xml.nil?
        db = DB.connect
        @preferences_xml = ""
        db.exec("select xml from sakai_preferences " +
                "where preferences_id=:userid", @user_id) do |row|
          REXML::Document.new(row[0].read).write(@preferences_xml, 2)
        end
      end
      @preferences_xml
    end

    # finders/counters
    def self.count
      DB.connect[:sakai_user].count
    end

    def self.count_by_realm_id_and_role_id(realm_id, role_id)
      count = 0
      DB.connect.exec("select count(*) from sakai_realm_rl_gr " +
                      "where realm_key = :realm_id " +
                      "and role_key = :role_id", realm_id, role_id) do |row|
        count = row[0].to_i
      end
      count
    end

    def self.find_by_realm_id_and_role_id(realm_id, role_id)
      users = []
      DB.connect.exec("select first_name, last_name, type, " +
                      "to_char(createdon,'YYYY-MM-DD HH24:MI:SS'), " +
                      "to_char(modifiedon,'YYYY-MM-DD HH24:MI:SS') " +
                      "from sakai_user where user_id in " +
                      "(select user_id from sakai_realm_rl_gr " +
                      "where realm_key = :realm_id " +
                      "and role_key = :role_id)", realm_id, role_id) do |row|
        first_name, last_name, type, created_at, modified_at = *row
        first_name ||= ""
        last_name ||= ""
        @@cache[eid] =
          @@cache[user_id] =
          User.new(user_id, eid, (first_name+' '+last_name), type, created_at, modified_at)
        users << @@cache[eid]
      end
      users
    end

    # yaml/json serialization
    def default_serialization
      {
        "id" => self.id,
        "name" => self.name,
        "eid" => self.eid,
        "type" => self.type,
        "created_at" => self.created_at,
        "user_properties" => UserProperty.find_by_user_id(self.id),
        "site_count" => self.site_count,
        "question_pool_count" => self.question_pool_count
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "eid" => self.eid,
        "name" => self.name,
        "type" => self.type
      }
    end

    def membership_serialization
      {
        "sites" => self.membership.collect { |sm| sm.serialize(:user_summary) }
      }
    end

    def question_pools_serialization
      if self.question_pool_count > 0
        {
          "question_pools" => self.question_pools.collect { |qp| qp.serialize(:user_summary) }
        }
      else
        {}
      end
    end
  end

  class UserProperty
    def self.get(user_id, property_name)
      db = DB.connect
      value = nil
      db.exec("select value from sakai_user_property " +
              "where user_id=:user_id and name=:name", user_id, property_name) do |row|
        value = row[0].read
      end
      return value
    end

    def self.find_by_user_id(user_id)
      db = DB.connect
      properties = {}
      db.exec("select name, value from sakai_user_property " +
              "where user_id=:user_id", user_id) do |row|
        name = row[0]
        value = row[1].read
        properties[name] = value
      end
      return properties
    end
  end
end

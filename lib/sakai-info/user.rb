# sakai-info/user.rb
#   SakaiInfo::User library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-10-06 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class User < SakaiObject
    attr_reader :eid, :name, :type, :email, :dbrow

    include ModProps
    created_by_key :createdby
    created_at_key :createdon
    modified_by_key :modifiedby
    modified_at_key :modifiedon

    def self.clear_cache
      @@cache = {}
      @@id_cache = {}
    end
    clear_cache

    def self.find(id)
      if @@cache[id].nil?
        eid = User.get_eid(id)
        user_id = User.get_user_id(id)
        if eid.nil? or user_id.nil?
          raise ObjectNotFoundException.new(User, id)
        end

        row = DB.connect[:sakai_user].where(:user_id => user_id).first
        if row.nil?
          # Has sakai_user_id_map record, but not sakai_user record. Provided account!
          # TODO: replace with a ProvidedUser subclass
          @@cache[eid] = @@cache[user_id] = User.new(user_id,'Provided')
        else
          @@cache[eid] = @@cache[user_id] = User.new(row)
        end
      end
      @@cache[id]
    end

    def self.get_ids(id)
      @@id_cache[id] ||=
        DB.connect[:sakai_user_id_map].where({:user_id => id, :eid => id}.sql_or).first
    end

    def self.get_eid(id)
      if ids = User.get_ids(id)
        ids[:eid]
      else
        nil
      end
    end

    def self.get_user_id(id)
      if ids = User.get_ids(id)
        ids[:user_id]
      else
        nil
      end
    end

    def initialize(*args)
      case args.size
      when 1
        dbrow = args[0]
        @dbrow = dbrow
        @id = dbrow[:user_id]
        @eid = User.get_eid(@id)
        @email = dbrow[:email]
        @name = ((dbrow[:first_name] || "") + " " + (dbrow[:last_name] || "")).strip
        @type = dbrow[:type]
      when 2
        user_id, placeholder_string = args
        @id = user_id
        @eid=User.get_eid(@id)
        @email = @name = @type = placeholder_string
      else
        raise ArgumentError, "This method takes 1-2 arguments"
      end
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
      @question_pool_count ||= QuestionPool.count_by_user_id(@id)
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
        @preferences_xml = ""
        row = DB.connect[:sakai_preferences].filter(:preferences_id => @user_id).first
        if not row.nil?
          REXML::Document.new(row[:xml].read).write(@preferences_xml, 2)
        end
      end
      @preferences_xml
    end

    # finders/counters
    def self.count
      DB.connect[:sakai_user].count
    end

    def self.count_by_realm_id_and_role_id(realm_id, role_id)
      DB.connect[:sakai_realm_rl_gr].
        filter(:realm_key => realm_id, :role_key => role_id).count
    end

    def self.find_by_realm_id_and_role_id(realm_id, role_id)
      # TODO: implement this correctly
      #  (code below isn't going to work)
      # users = []
      # DB.connect.fetch("select first_name, last_name, type, " +
      #                  "to_char(createdon,'YYYY-MM-DD HH24:MI:SS') as created_at, " +
      #                  "to_char(modifiedon,'YYYY-MM-DD HH24:MI:SS') as modified_at " +
      #                  "from sakai_user where user_id in " +
      #                  "(select user_id from sakai_realm_rl_gr " +
      #                  "where realm_key = ? " +
      #                  "and role_key = ?)", realm_id, role_id) do |row|
      #   first_name, last_name, type, created_at, modified_at = *row
      #   first_name ||= ""
      #   last_name ||= ""
      #   @@cache[eid] =
      #     @@cache[user_id] =
      #     User.new(user_id, eid, (first_name+' '+last_name), type, created_at, modified_at)
      #   users << @@cache[eid]
      # end
      # users
      nil
    end

    # by_name: uses like
    def self.query_by_name(name)
      DB.connect[:sakai_user].where("upper(first_name) like ? or upper(last_name) like ? or upper(first_name)||\' \'||upper(last_name) like ?", "%#{name.upcase}%", "%#{name.upcase}%", "%#{name.upcase}%")
    end

    def self.find_by_name(name)
      User.query_by_name(name).all.collect{|row| @@cache[row[:user_id]] = User.new(row)}
    end

    def self.find_ids_by_name(name)
      User.query_by_name(name).select(:user_id).all.collect{|row|row[:user_id]}
    end

    # yaml/json serialization
    def default_serialization
      result = {
        "id" => self.id,
        "name" => self.name,
        "eid" => self.eid,
        "email" => self.email,
        "type" => self.type,
        "user_properties" => UserProperty.find_by_user_id(self.id),
        "site_count" => self.site_count,
        "question_pool_count" => self.question_pool_count
      }
      if result["user_properties"] == {}
        result.delete("user_properties")
      end
      result
    end

    def summary_serialization
      {
        "id" => self.id,
        "eid" => self.eid,
        "name" => self.name,
        "type" => self.type
      }
    end

    def sites_serialization
      {
        "sites" => self.membership.collect { |sm| sm.serialize(:user_summary) }
      }
    end

    def pools_serialization
      if self.question_pool_count > 0
        {
          "question_pools" => self.question_pools.collect { |qp| qp.serialize(:user_summary) }
        }
      else
        {}
      end
    end

    def self.all_serializations
      [
       :default,
       :sites,
       :pools,
       :mod,
      ]
    end
  end

  class UserProperty
    def self.get(user_id, property_name)
      row = DB.connect[:sakai_user_property].
        filter(:user_id => user_id, :name => property_name).first
      if row.nil?
        nil
      else
        row[:value].read
      end
    end

    def self.find_by_user_id(user_id)
      properties = {}
      DB.connect[:sakai_user_property].
        where(:user_id => user_id).all.each do |row|
        properties[row[:name]] = row[:value].read
      end
      return properties
    end
  end
end

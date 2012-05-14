# sakai-info/site.rb
#   SakaiInfo::Site library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-05-14 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Site < SakaiObject
    attr_reader :title, :type, :dbrow

    include ModProps
    created_by_key :createdby
    created_at_key :createdon
    modified_by_key :modifiedby
    modified_at_key :modifiedon

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:sakai_site].where(:site_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(Site, id)
        end

        @@cache[id] = Site.new(row)
      end
      @@cache[id]
    end

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:site_id]
      @title = dbrow[:title]
      @type = dbrow[:type]
      @is_joinable = (dbrow[:joinable].to_i == 1)
      @is_published = (dbrow[:published].to_i == 1)
      @join_role_string = dbrow[:join_role].to_s
    end

    def joinable?
      @is_joinable
    end

    def published?
      @is_published
    end

    def join_role
      @join_role_string
    end

    def properties
      @properties ||= SiteProperty.find_by_site_id(@id)
    end

    def membership
      @membership ||= SiteMembership.find_by_site_id(@id)
    end

    def pages
      @pages ||= Page.find_by_site_id(@id)
    end

    def assignments
      @assignments ||= Assignment.find_by_site_id(@id)
    end

    def user_count
      @user_count ||=
        DB.connect[:sakai_site_user].filter(:site_id => @id).count
    end

    def page_count
      @page_count ||=
        DB.connect[:sakai_site_page].filter(:site_id => @id).count
    end

    def assignment_count
      @assignment_count ||= Assignment.count_by_site_id(@id)
    end

    # authz/realm properties
    def realm
      @authz_realm ||= AuthzRealm.find_by_site_id(@id)
    end

    def join_role
      @join_role ||= AuthzRole.find_by_name(@join_role_string)
    end

    # group properties
    def group_count
      @group_count ||= Group.count_by_site_id(@id)
    end

    def groups
      @groups ||= Group.find_by_site_id(@id)
    end

    # announcement properties
    def announcement_channel
      if @announcement_channel.nil?
        begin
          @announcement_channel = AnnouncementChannel.find_by_site_id(self.id)
        rescue ObjectNotFoundException
          @announcement_channel = -1
          return nil
        end
      elsif @announcement_channel == -1
        return nil
      end
      @announcement_channel
    end

    def announcements
      return nil if self.announcement_channel.nil?
      @announcements ||= self.announcement_channel.announcements
    end

    def announcement_count
      return 0 if self.announcement_channel.nil?
      @announcement_count ||= self.announcement_channel.announcement_count
    end

    # samigo quiz properties
    def published_quiz_count
      @published_quiz_count ||= PublishedQuiz.count_by_site_id(@id)
    end

    def pending_quiz_count
      @pending_quiz_count ||= PendingQuiz.count_by_site_id(@id)
    end

    def published_quizzes
      @published_quizzes ||= PublishedQuiz.find_by_site_id(@id)
    end

    def pending_quizzes
      @pending_quizzes ||= PendingQuiz.find_by_site_id(@id)
    end

    # gradebook properties
    def gradebook
      @gradebook ||= Gradebook.find_by_site_id(@id).first
    end

    # forum properties
    def forum_count
      @forum_count ||= Forum.count_by_site_id(@id)
    end

    def forums
      @forums ||= Forum.find_by_site_id(@id)
    end

    # content properties
    def resource_storage
      resource_collection_id = "/group/#{@id}/"
      if @type == "myworkspace" or @type == "guestworkspace"
        resource_collection_id = "/user/#{@id.sub(/^~/,'')}"
      end
      @resource_storage ||= ContentCollection.find!(resource_collection_id)
    end

    def attachment_storage
      attachment_collection_id = "/attachment/#{@id}/"
      @attachment_storage ||= ContentCollection.find!(attachment_collection_id)
    end

    def melete_storage
      melete_collection_id = "/private/meleteDocs/#{@id}/"
      @melete_storage ||= ContentCollection.find!(melete_collection_id)
    end

    def dropbox_storage
      dropbox_collection_id = "/group-user/#{@id}/"
      @dropbox_storage ||= ContentCollection.find!(dropbox_collection_id)
    end

    def total_disk_usage
      resource_storage.size_on_disk + attachment_storage.size_on_disk + melete_storage.size_on_disk + dropbox_storage.size_on_disk
    end

    # generate a CSV line for disk usage reporting
    def disk_usage_csv
      "#{@id},#{@type},#{resource_storage.size_on_disk},#{attachment_storage.size_on_disk},#{melete_storage.size_on_disk},#{dropbox_storage.size_on_disk},#{total_disk_usage}"
    end

    # finders/counters
    def self.count
      DB.connect[:sakai_site].count
    end

    def self.count_by_user_id(user_id)
      DB.connect[:sakai_site_user].where(:user_id => user_id).count
    end

    def self.count_by_property(name, value)
      DB.connect[:sakai_site_property].
        where(:name => name, :to_char.sql_function(:value) => value).count
    end

    def self.find_ids_by_property(property_name, property_value)
      SiteProperty.find_site_ids_by_property(property_name, property_value)
    end

    def self.find_ids_by_semester(term_eid)
      Site.find_ids_by_property("term_eid", term_eid)
    end

    def self.find_all_ids
      DB.connect[:sakai_site].select(:site_id).all.collect{|r| r[:site_id]}
    end

    def self.find_all_workspace_ids
      DB.connect[:sakai_site].select(:site_id).
        where(:site_id.like("~%")).all.collect{|r| r[:site_id]}
    end

    def self.find_all_non_workspace_ids
      DB.connect[:sakai_site].select(:site_id).
        where(~:site_id.like("~%")).all.collect{|r| r[:site_id]}
    end

    def self.find_ids_by_type(type)
      DB.connect[:sakai_site].select(:site_id).
        where(:type => type).all.collect{|r| r[:site_id]}
    end

    # by_type queries
    def self.query_by_type(type)
      DB.connect[:sakai_site].where(:type => type)
    end

    def self.count_by_type(type)
      Site.query_by_type(type).count
    end

    def self.find_by_type(type)
      Site.query_by_type(type).all.collect{|row| @@cache[row[:site_id]] = Site.new(row)}
    end

    ############################################################
    # serialization methods
    def default_serialization
      result = {
        "id" => self.id,
        "title" => self.title,
        "type" => self.type,
        "is_published" => self.published?,
        "site_properties" => self.properties,
        "providers" => self.realm.providers,
        "is_joinable" => self.joinable?,
        "join_role" => (self.joinable? ? self.join_role.name : nil),
        "user_count" => self.user_count,
        "group_count" => self.group_count,
        "page_count" => self.page_count,
        "pending_quiz_count" => self.pending_quiz_count,
        "published_quiz_count" => self.published_quiz_count,
        "assignment_count" => self.assignment_count,
        "announcement_count" => self.announcement_count,
        "gradebook_item_count" => (self.gradebook.nil? ? 0 : self.gradebook.item_count),
        "forum_count" => self.forum_count
      }
      if result["providers"].nil? or result["providers"] == "" or result["providers"] == []
        result.delete("providers")
      end
      if result["is_joinable"] == false
        result.delete("join_role")
      end
      if result["site_properties"] == {}
        result.delete("site_properties")
      end
      if self.gradebook.nil?
        result.delete("gradebook_item_count")
      end
      result
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "type" => self.type,
        "created_by" => self.created_by.eid
      }
    end

    def users_serialization
      {
        "users" => self.membership.collect { |sm| sm.serialize(:site_summary) }
      }
    end

    def pages_serialization
      {
        "pages" => self.pages.collect { |pg| pg.serialize(:site_summary) }
      }
    end

    def groups_serialization
      {
        "groups" => self.groups.collect { |grp| grp.serialize(:summary) }
      }
    end

    def quizzes_serialization
      result = {}
      if self.pending_quiz_count > 0 or self.published_quiz_count > 0
        result["quizzes"] = {}
      end
      if self.pending_quiz_count > 0
        result["quizzes"]["pending"] =
          self.pending_quizzes.collect { |pq| pq.serialize(:site_summary) }
      end
      if self.published_quiz_count > 0
        result["quizzes"]["published"] =
          self.published_quizzes.collect { |pq| pq.serialize(:site_summary) }
      end
      result
    end

    def disk_unformatted_serialization
      {
        "disk_usage" => {
          "resources" => self.resource_storage.size_on_disk,
          "attachments" => self.attachment_storage.size_on_disk,
          "melete" => self.melete_storage.size_on_disk,
          "dropbox" => self.dropbox_storage.size_on_disk,
          "total" => (self.resource_storage.size_on_disk +
                      self.attachment_storage.size_on_disk +
                      self.melete_storage.size_on_disk +
                      self.dropbox_storage.size_on_disk)
        }
      }
    end

    def disk_serialization
      result = disk_unformatted_serialization["disk_usage"]
      result.keys.each do |key|
        result[key] = Util.format_filesize(result[key])
      end
      {
        "disk_usage" => result
      }
    end

    def assignments_serialization
      if self.assignment_count > 0
        {
          "assignments" => self.assignments.collect { |asn| asn.serialize(:summary) }
        }
      else
        {}
      end
    end

    def announcements_serialization
      if self.announcement_count > 0
        {
          "announcements" => self.announcements.collect { |annc| annc.serialize(:summary) }
        }
      else
        {}
      end
    end

    def gradebook_serialization
      if self.gradebook
        {
          "gradebook" => self.gradebook.serialize(:site_summary, :items)
        }
      else
        {}
      end
    end

    def realm_serialization
      {
        "realm_roles" => self.realm.realm_roles.collect { |rr| rr.serialize(:summary) }
      }
    end

    def forums_serialization
      if self.forum_count > 0
        {
          "forums" => self.forums.collect { |fr| fr.serialize(:summary) }
        }
      else
        {}
      end
    end

    def self.all_serializations
      [
       :default,
       :users,
       :pages,
       :groups,
       :quizzes,
       :disk,
       :assignments,
       :announcements,
       :gradebook,
       :realm,
       :forums,
       :mod,
      ]
    end
  end

  class SiteProperty
    def self.get(site_id, property_name)
      row = DB.connect[:sakai_site_property].
        where(:site_id => site_id, :name => property_name).first
      if row.nil?
        nil
      else
        row[:value].read
      end
    end

    def self.find_by_site_id(site_id)
      properties = {}
      DB.connect[:sakai_site_property].
        where(:site_id => site_id).all.each do |row|
        properties[row[:name]] = row[:value].read
      end
      return properties
    end

    def self.find_site_ids_by_property(name, value)
      DB.connect[:sakai_site_property].
        where(:name => name, :to_char.sql_function(:value) => value).
        all.collect{|r| r[:site_id]}
    end
  end

  class SiteMembership < SakaiObject
    attr_reader :site, :user, :role

    def initialize(site_id, user_id, role)
      @site = Site.find(site_id)
      @user = User.find(user_id)
      @role = AuthzRole.find(role)
    end

    def self.find_by_site_id(site_id)
      results = []
      DB.connect.fetch("select srrg.user_id, srr.role_name " +
                       "from sakai_realm_rl_gr srrg, sakai_realm_role srr, sakai_realm sr " +
                       "where srrg.role_key = srr.role_key " +
                       "and srrg.realm_key = sr.realm_key " +
                       "and sr.realm_id = '/site/' || ? ", site_id) do |row|
        results << SiteMembership.new(site_id, row[:user_id], row[:role_name])
      end
      results
    end

    def self.find_by_user_id(user_id)
      results = []
      DB.connect.fetch("select substr(sr.realm_id,7) as site_id, srr.role_name as role_name " +
                       "from sakai_realm_rl_gr srrg, sakai_realm_role srr, sakai_realm sr " +
                       "where srrg.role_key = srr.role_key " +
                       "and srrg.realm_key = sr.realm_key " +
                       "and srrg.user_id = ? " +
                       "and sr.realm_id like '/site/%' " +
                       "and sr.realm_id not like '%/group/%'", user_id) do |row|
        results << SiteMembership.new(row[:site_id], user_id, row[:role_name])
      end
      results
    end

    def default_serialization
      {
        "site" => self.site.serialize(:summary),
        "user" => self.user.serialize(:summary),
        "role" => self.role.name
      }
    end

    def summary_serialization
      {
        "site_id" => self.site.id,
        "site_title" => self.site.title,
        "user_id" => self.user.id,
        "user_eid" => self.user.eid,
        "user_type" => self.user.type,
        "role" => self.role.name
      }
    end

    def user_summary_serialization
      {
        "site_id" => self.site.id,
        "site_title" => self.site.title,
        "role" => self.role.name
      }
    end

    def site_summary_serialization
      {
        "user_id" => self.user.id,
        "user_eid" => self.user.eid,
        "user_type" => self.user.type,
        "role" => self.role.name
      }
    end
  end
end

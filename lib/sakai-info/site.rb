# sakai-info/site.rb
#   SakaiInfo::Site library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-24 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Site < SakaiObject
    attr_reader :title, :type
    attr_reader :created_at, :modified_at

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        db = DB.connect
        row = db.fetch("select site_id, title, type, " +
                       "createdby,  modifiedby, " +
                       "to_char(createdon,'YYYY-MM-DD HH24:MI:SS') as created_at, " +
                       "to_char(modifiedon,'YYYY-MM-DD HH24:MI:SS') as modified_at, " +
                       "joinable, join_role " +
                       "from sakai_site where site_id=?", id).first
        if row.nil?
          raise ObjectNotFoundException.new(Site, id)
        end

        joinable = false
        if row[:joinable].to_i == 1
          joinable = true
        end

        @@cache[id] = Site.new(id, row[:title], row[:type], row[:createdby],
                               row[:created_at], row[:modifiedby], row[:modified_at],
                               joinable, row[:join_role])
      end
      @@cache[id]
    end

    def initialize(id, title, type, created_by_user_id, created_at, modified_by_user_id, modified_at, joinable, join_role)
      @id = id
      @title = title
      @type = type
      @created_by_user_id = created_by_user_id
      @created_at = created_at
      @modified_by_user_id = modified_by_user_id
      @modified_at = modified_at
      @joinable = joinable
      @join_role_string = join_role.to_s
    end

    def joinable?
      @joinable
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

    def created_by
      @created_by ||= User.find(@created_by_user_id)
    end

    def modified_by
      @modified_by ||= User.find(@modified_by_user_id)
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
    def announcements
      @announcements ||= AnnouncementChannel.find_by_site_id(@id).announcements
    end

    def announcement_count
      @announcement_count ||= AnnouncementChannel.find_by_site_id(@id).announcement_count
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
      @gradebook ||= Gradebook.find_by_site_id(@id)
    rescue ObjectNotFoundException
      # not all sites have a gradebook, don't panic
      nil
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

    def self.count_by_type(type)
      DB.connect[:sakai_site].where(:type => type).count
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

    def self.find_by_type(type)
      sites = []
      DB.connect.fetch("select site_id, title, type, " +
                       "createdby, modifiedby, " +
                       "to_char(createdon,'YYYY-MM-DD HH24:MI:SS') as created_at, " +
                       "to_char(modifiedon,'YYYY-MM-DD HH24:MI:SS') as modified_at, " +
                       "joinable, join_role " +
                       "from sakai_site where type = ?", type) do |row|
        joinable = false
        if joinable_n.to_i == 1
          joinable = true
        end
        @@cache[row[:site_id]] = Site.new(row[:site_id], row[:title], row[:type], row[:createdby], row[:created_at], row[:modifiedby], row[:modified_at], joinable, row[:join_role])
        sites << @@cache[row[:site_id]]
      end
      sites
    end

    # serialization methods
    def default_serialization
      result = {
        "id" => self.id,
        "title" => self.title,
        "type" => self.type,
        "created_at" => self.created_at,
        "created_by" => self.created_by.serialize(:summary),
        "site_properties" => self.properties,
        "providers" => self.realm.providers,
        "joinable" => self.joinable?,
        "join_role" => (self.joinable? ? self.join_role : nil),
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
      if result["providers"].nil? or result["providers"] == ""
        result.delete("providers")
      end
      if result["joinable"] == false
        result.delete("join_role")
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
        "pages" => self.pages.collect { |pg| pg.serialize(:summary) }
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
          self.pending_quizzes.collect { |pq| pq.serialize(:summary) }
      end
      if self.published_quiz_count > 0
        result["quizzes"]["published"] =
          self.published_quizzes.collect { |pq| pq.serialize(:summary) }
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
      if self.gradebook and self.gradebook.item_count > 0
        {
          "gradebook_items" => self.gradebook.items.collect { |item| item.serialize(:summary) }
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
       :default, :users, :pages, :groups, :quizzes, :disk, :assignments,
       :announcements, :gradebook, :realm, :forums
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
      DB.connect[:sakai_site_property].where(:site_id => site_id).all.each do |row|
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

  class Page < SakaiObject
    attr_reader :title, :order, :layout, :site

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:sakai_site_page].where(:page_id => id).first
        if row.nil?
          raise ObjectNotFoundException(Page, id)
        end

        site = Site.find(row[:site_id])
        @@cache[id] = Page.new(id, row[:title], row[:order].to_i, row[:layout], site)
      end
      @@cache[id]
    end

    def self.find_by_site_id(site_id)
      results = []
      site = Site.find(site_id)
      DB.connect[:sakai_site_page].
        where(:site_id => site_id).order(:site_order).all.each do |row|
        @@cache[row[:page_id]] =
          Page.new(row[:page_id], row[:title], row[:site_order].to_i,
                   row[:layout], site)
        results << @@cache[row[:page_id]]
      end
      results
    end

    def initialize(id, title, order, layout, site)
      @id = id
      @title = title
      @order = order
      @layout = layout
      @site = site
    end

    def properties
      @properties ||= PageProperty.find_by_page_id(@id)
    end

    def tools
      @tools ||= Tool.find_by_page_id(@id)
    end

    # serialization
    def default_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "order" => self.order,
        "tools" => self.tools.collect { |tool| tool.serialize(:summary) },
        "properties" => self.properties,
        "site_id" => self.site.id
      }.delete_if do |k,v|
        k == "properties" && v == {}
      end
    end

    def summary_serialization
      default_serialization.delete_if do |k,v|
        k == "site_id"
      end
    end
  end

  class PageProperty
    def self.get(page_id, property_name)
      row = DB.connect[:sakai_site_page_property].
        filter(:page_id => page_id, :name => property_name).first
      if row.nil?
        nil
      else
        row[:value].read
      end
    end

    def self.find_by_page_id(page_id)
      properties = {}
      DB.connect[:sakai_site_page_property].where(:page_id => page_id).all.each do |row|
        properties[row[:name]] = row[:value].read
      end
      return properties
    end
  end

  class Tool < SakaiObject
    attr_reader :title, :registration, :order, :layout, :page, :site

    @@cache = {}
    def self.find(id)
      if @@cache[id].nil?
        row = DB.connect[:sakai_site_tool].where(:tool_id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(Tool, id)
        end

        page = Page.find(row[:page_id])
        @@cache[id] =
          Tool.new(id, row[:title], row[:registration], row[:page_order].to_i,
                   row[:layout_hints], page)
      end
      @@cache[id]
    end

    def self.find_by_page_id(page_id)
      results = []
      page = Page.find(page_id)
      DB.connect[:sakai_site_tool].
        where(:page_id => page_id).order(:page_order).all.each do |row|
        @@cache[row[:tool_id]] =
          Tool.new(row[:tool_id], row[:title], row[:registration], row[:page_order].to_i,
                   row[:layout_hints], page)
        results << @@cache[row[:tool_id]]
      end
      results
    end

    def initialize(id, title, registration, order, layout, page)
      @id = id
      @title = title
      @registration = registration
      @order = order
      @layout = layout
      @page = page
      @site = page.site
    end

    def properties
      @properties ||= ToolProperty.find_by_tool_id(@id)
    end

    # serialization
    def default_serialization
      result = {
        "id" => self.id,
        "registration" => self.registration,
        "title" => self.title,
        "site" => self.site.serialize(:summary),
        "page_id" => self.page.id,
        "order" => self.order,
        "layout" => self.layout,
        "properties" => self.properties
      }
      if result["properties"] == {}
        result.delete("properties")
      end
      if result["layout"].nil?
        result.delete("layout")
      end
      result
    end

    def summary_serialization
      {
        "id" => self.id,
        "registration" => self.registration,
        "title" => self.title
      }
    end
  end

  class ToolProperty
    def self.get(tool_id, property_name)
      row = DB.connect[:sakai_site_tool_property].
        filter(:tool_id => tool_id, :name => property_name).first
      if row.nil?
        nil
      else
        row[:value].read
      end
    end

    def self.find_by_tool_id(tool_id)
      properties = {}
      DB.connect[:sakai_site_tool_property].where(:tool_id => tool_id).all.each do |row|
        properties[row[:name]] = row[:value].read
      end
      return properties
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

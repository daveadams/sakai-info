# sakai-info/authz.rb
#   SakaiInfo::Authz library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-10-25 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class AuthzRole < SakaiObject
    attr_reader :name

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(dbrow)
      @dbrow = dbrow

      @id = @dbrow[:role_key].to_i
      @name = @dbrow[:role_name]
    end

    def to_s
      name
    end

    def self.find_by_id(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect[:sakai_realm_role].where(:role_key => id.to_i).first
        if row.nil?
          raise ObjectNotFoundException.new(AuthzRole, id)
        end
        @@cache[id] = AuthzRole.new(row)
        @@cache[@@cache[id].name] = @@cache[id]
      end
      @@cache[id]
    end

    def self.find_by_name(name)
      if name.nil?
        raise ObjectNotFoundException.new(AuthzRole, "")
      end
      if @@cache[name].nil?
        row = DB.connect[:sakai_realm_role].where(:role_name => name).first
        if row.nil?
          raise ObjectNotFoundException.new(AuthzRole, name)
        end
        @@cache[name] = AuthzRole.new(row)
        @@cache[@@cache[name].id] = @@cache[name]
      end
      @@cache[name]
    end

    def self.find(id_or_name)
      id_or_name = id_or_name.to_s
      role = nil
      begin
        role = AuthzRole.find_by_name(id_or_name)
      rescue ObjectNotFoundException
        # just in case
        role = AuthzRole.find_by_id(id_or_name)
      end
      if role.nil?
        raise ObjectNotFoundException.new(AuthzRole, id_or_name)
      end
      role
    end

    def self.query_by_realm_id_and_function_id(realm_id, function_id)
      DB.connect[:sakai_realm_role].
        where(:role_key => DB.connect[:sakai_realm_rl_fn].select(:role_key).
              where(:realm_key => realm_id, :function_key => function_id))
    end

    def self.count_by_realm_id_and_function_id(realm_id, function_id)
      AuthzRole.query_by_realm_id_and_function_id(realm_id, function_id).count
    end

    def self.find_by_realm_id_and_function_id(realm_id, function_id)
      AuthzRole.query_by_realm_id_and_function_id(realm_id, function_id).
        order(:role_name).all.collect { |row| AuthzRole.new(row) }
    end

    def default_serialization
      {
        "id" => self.id,
        "name" => self.name,
      }
    end
  end

  class AuthzFunction < SakaiObject
    attr_reader :name

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(dbrow)
      @dbrow = dbrow

      @id = @dbrow[:function_key].to_i
      @name = @dbrow[:function_name]
    end

    def to_s
      name
    end

    def self.find_by_id(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect[:sakai_realm_function].where(:function_key => id.to_i).first
        if row.nil?
          raise ObjectNotFoundException.new(AuthzFunction, id)
        end
        @@cache[id] = AuthzFunction.new(row)
        @@cache[@@cache[id].name] = @@cache[id]
      end
      @@cache[id]
    end

    def self.find_by_name(name)
      if name.nil?
        raise ObjectNotFoundException.new(AuthzFunction, "")
      end
      if @@cache[name].nil?
        row = DB.connect[:sakai_realm_function].where(:function_name => name).first
        if row.nil?
          raise ObjectNotFoundException.new(AuthzFunction, name)
        end
        @@cache[name] = AuthzFunction.new(row)
        @@cache[@@cache[name].id] = @@cache[name]
      end
      @@cache[name]
    end

    def self.find(id_or_name)
      id_or_name = id_or_name.to_s
      function = nil
      begin
        function = AuthzFunction.find_by_name(id_or_name)
      rescue ObjectNotFoundException
        # just in case
        function = AuthzFunction.find_by_id(id_or_name)
      end
      if function.nil?
        raise ObjectNotFoundException.new(AuthzFunction, id_or_name)
      end
      function
    end

    def self.query_by_realm_id_and_role_id(realm_id, role_id)
      DB.connect[:sakai_realm_function].
        where(:function_key => DB.connect[:sakai_realm_rl_fn].select(:function_key).
              where(:realm_key => realm_id, :role_key => role_id))
    end

    def self.count_by_realm_id_and_role_id(realm_id, role_id)
      AuthzFunction.query_by_realm_id_and_role_id(realm_id, role_id).count
    end

    def self.find_by_realm_id_and_role_id(realm_id, role_id)
      AuthzFunction.query_by_realm_id_and_role_id(realm_id, role_id).
        order(:function_name).all.collect { |row| AuthzFunction.new(row) }
    end

    def default_serialization
      {
        "id" => self.id,
        "name" => self.name,
      }
    end
  end

  class AuthzRealm < SakaiObject
    attr_reader :name, :providers, :maintain_role

    include ModProps
    created_at_key :createdon
    created_by_key :createdby
    modified_at_key :modifiedon
    modified_by_key :modifiedby

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(row)
      @dbrow = row

      @id = @dbrow[:realm_key].to_i
      @name = @dbrow[:realm_id]
      if @dbrow[:provider_id].nil?
        @providers = nil
      else
        @providers = @dbrow[:provider_id].split("+")
      end
      if @dbrow[:maintain_role].nil? or @dbrow[:maintain_role] == ""
        @maintain_role = nil
      else
        @maintain_role = AuthzRole.find_by_id(@dbrow[:maintain_role])
      end
    end

    def realm_roles
      @realm_roles ||= AuthzRealmRole.find_by_realm_id(self.id)
    end

    def to_s
      name
    end

    def user_count
      @user_count ||= AuthzRealmMembership.count_by_realm_id(self.id)
    end

    def users
      @users ||= AuthzRealmMembership.find_by_realm_id(self.id)
    end

    def self.find_by_id(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect[:sakai_realm].where(:realm_key => id.to_i).first
        if row.nil?
          raise ObjectNotFoundException.new(AuthzRealm, id)
        end
        @@cache[id] = AuthzRealm.new(row)
        @@cache[@@cache[id].name] = @@cache[id]
      end
      @@cache[id]
    end

    def self.find_by_name(name)
      if @@cache[name].nil?
        row = DB.connect[:sakai_realm].where(:realm_id => name).first
        if row.nil?
          raise ObjectNotFoundException.new(AuthzRealm, name)
        end
        @@cache[name] = AuthzRealm.new(row)
        @@cache[@@cache[name].id] = @@cache[name]
      end
      @@cache[name]
    end

    def self.find(id_or_name)
      id_or_name = id_or_name.to_s
      realm = nil
      begin
        realm = AuthzRealm.find_by_name(id_or_name)
      rescue ObjectNotFoundException
        # just in case
        realm = AuthzRealm.find_by_id(id_or_name)
      end
      if realm.nil?
        raise ObjectNotFoundException.new(AuthzRealm, id_or_name)
      end
      realm
    end

    def self.find!(id_or_name)
      begin
        realm = AuthzRealm.find(id_or_name)
      rescue ObjectNotFoundException => e
        if e.classname == AuthzRealm.name
          realm = MissingAuthzRealm.find(id_or_name)
        end
      end
      realm
    end


    def self.find_by_site_id(site_id)
      AuthzRealm.find_by_name("/site/#{site_id}")
    end

    def self.find_by_site_id_and_group_id(site_id, group_id)
      AuthzRealm.find_by_name("/site/#{site_id}/group/#{group_id}")
    end

    def default_serialization
      result = {
        "id" => self.id,
        "name" => self.name,
        "user_count" => self.user_count,
      }
      if not self.providers.nil?
        result["providers"] = self.providers
      end
      if not self.maintain_role.nil?
        result["maintain_role"] = self.maintain_role.name
      end
      result
    end

    def summary_serialization
      {
        "id" => self.id,
        "name" => self.name,
      }
    end

    def roles_serialization
      {
        "roles" => self.realm_roles.collect { |rr| rr.serialize(:realm_summary) }
      }
    end

    def users_serialization
      {
        "users" => self.users.collect { |u| u.serialize(:realm_summary) }
      }
    end

    def self.all_serializations
      [
       :default,
       :mod,
       :roles,
       :users,
      ]
    end
  end

  class MissingAuthzRealm < AuthzRealm
    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def initialize(id)
      @dbrow = {}

      @dbrow = {}

      @id = id
      @name = id
      @providers = nil
      @maintain_role = nil
    end

    def self.find(id)
      @@cache[id] ||= MissingAuthzRealm.new(id)
    end

    def realm_roles
      []
    end

    def users
      []
    end

    def default_serialization
      {
        "id" => "MISSING REALM: #{self.id}",
      }
    end

    def summary_serialization
      {
        "id" => "MISSING REALM: #{self.id}",
      }
    end

    def self.all_serializations
      [
       :default,
      ]
    end
  end

  class AuthzRealmRole < SakaiObject
    attr_reader :realm, :role

    def initialize(realm, role)
      @realm = realm
      @role = role
    end

    def function_count
      @function_count ||=
        AuthzFunction.count_by_realm_id_and_role_id(self.realm.id, self.role.id)
    end

    def functions
      @functions ||=
        AuthzFunction.find_by_realm_id_and_role_id(self.realm.id, self.role.id)
    end

    def user_count
      @user_count ||=
        User.count_by_realm_id_and_role_id(self.realm.id, self.role.id)
    end

    def users
      @users ||=
        User.find_by_realm_id_and_role_id(self.realm.id, self.role.id)
    end

    def self.find_by_realm_id(realm_id)
      realm_roles = []
      realm = AuthzRealm.find_by_id(realm_id)
      DB.connect.fetch("select distinct role_key from " +
                       "sakai_realm_rl_fn where " +
                       "realm_key = ?", realm_id) do |row|
        begin
          role = AuthzRole.find_by_id(row[:role_key].to_i)
          realm_roles << AuthzRealmRole.new(realm, role)
        rescue AuthzRoleNotFoundException
        end
      end
      realm_roles
    end

    def default_serialization
      {
        "realm_name" => self.realm.name,
        "role_name" => self.role.name,
        "user_count" => self.user_count,
        "function_count" => self.function_count,
      }
    end

    def summary_serialization
      {
        "realm" => self.realm.name,
        "role" => self.role.name,
      }
    end

    def realm_summary_serialization
      {
        "role" => self.role.name,
        "user_count" => self.user_count,
        "function_count" => self.function_count,
      }
    end
  end

  class AuthzRealmMembership < SakaiObject
    attr_reader :realm, :user, :role

    def initialize(realm_id, user_id, role)
      @realm = AuthzRealm.find(realm_id)
      @user = User.find(user_id)
      @role = AuthzRole.find(role)
    end

    def self.find_by_realm_id(realm_id)
      results = []
      DB.connect.fetch("select srrg.user_id as user_id, " +
                       "srr.role_name as role_name " +
                       "from sakai_realm_rl_gr srrg, sakai_realm_role srr " +
                       "where srrg.role_key = srr.role_key " +
                       "and srrg.realm_key = ?", realm_id) do |row|
        results << AuthzRealmMembership.new(realm_id, row[:user_id], row[:role_name])
      end
      results
    end

    def self.count_by_realm_id(realm_id)
      DB.connect[:sakai_realm_rl_gr].where(:realm_key => realm_id).count
    end

    def self.find_by_user_id(user_id)
      results = []
      DB.connect.fetch("select sr.realm_id as realm_id, " +
                       "srr.role_name as role_name " +
                       "from sakai_realm_rl_gr srrg, sakai_realm_role srr, sakai_realm sr " +
                       "where srrg.role_key = srr.role_key " +
                       "and srrg.realm_key = sr.realm_key " +
                       "and srrg.user_id = ?", user_id) do |row|
        results << AuthzRealmMembership.new(row[:realm_id], user_id, row[:role_name])
      end
      results
    end

    def default_serialization
      {
        "realm" => self.realm.serialize(:summary),
        "user" => self.user.serialize(:summary),
        "role" => self.role.serialize(:summary),
      }
    end

    def summary_serialization
      {
        "realm" => self.realm.name,
        "user" => self.user.eid,
        "role" => self.role.name,
      }
    end

    def realm_summary_serialization
      {
        "user" => self.user.eid,
        "role" => self.role.name,
      }
    end
  end
end

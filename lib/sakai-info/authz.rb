# sakai-info/authz.rb
#   SakaiInfo::Authz library
#
# Created 2012-02-17 daveadams@gmail.com
# Last updated 2012-02-17 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class AuthzRole < SakaiObject
    attr_reader :name

    def initialize(id, name)
      @id = id
      @name = name
    end

    def to_s
      name
    end

    @@cache = {}
    def self.find_by_id(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect.fetch("select role_name from sakai_realm_role " +
                               "where role_key = ?", id.to_i).first
        if row.nil?
          raise ObjectNotFoundException.new(AuthzRole, id)
        end
        @@cache[id] = AuthzRole.new(id, row[:role_name])
        @@cache[name] = @@cache[id]
      end
      @@cache[id]
    end

    def self.find_by_name(name)
      if name.nil?
        raise ObjectNotFoundException.new(AuthzRole, "")
      end
      if @@cache[name].nil?
        row = DB.connect.fetch("select role_key from sakai_realm_role " +
                               "where role_name = ?", name).first
        if row.nil?
          raise ObjectNotFoundException.new(AuthzRole, name)
        end
        id = row[:role_key].to_i.to_s
        @@cache[name] = AuthzRole.new(id, name)
        @@cache[id] = @@cache[name]
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

    def self.find_by_realm_id_and_function_id(realm_id, function_id)
      roles = []
      DB.connect.fetch("select role_key, role_name from " +
                       "sakai_realm_role where role_key in " +
                       "(select role_key from sakai_realm_rl_fn " +
                       "where realm_key=? and function_key=?) " +
                       "order by role_name", realm_id, function_id) do |row|
        role_id = row[:role_key].to_i.to_s
        role_name = row[:role_name]
        roles << AuthzRole.new(role_id, role_name)
      end
      roles
    end
  end

  class AuthzFunction < SakaiObject
    attr_reader :name

    def initialize(id, name)
      @id = id
      @name = name
    end

    def to_s
      name
    end

    @@cache = {}
    def self.find_by_id(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect.fetch("select function_name from sakai_realm_function " +
                               "where function_key = ?", id.to_i).first
        if row.nil?
          raise ObjectNotFoundException.new(AuthzFunction, id)
        end
        @@cache[id] = AuthzFunction.new(id, row[:function_name])
        @@cache[row[:function_name]] = @@cache[id]
      end
      @@cache[id]
    end

    def self.find_by_name(name)
      if @@cache[name].nil?
        id = nil
        row = DB.connect.fetch("select function_key from sakai_realm_function " +
                               "where function_name = ?", name).first
        if row.nil?
          raise ObjectNotFoundException.new(AuthzFunction, name)
        end
        id = row[:function_key].to_i.to_s
        @@cache[name] = AuthzFunction.new(id, name)
        @@cache[id] = @@cache[name]
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

    def self.count_by_realm_id_and_role_id(realm_id, role_id)
      DB.connect[:sakai_realm_rl_fn].
        filter(:realm_key => realm_id, :role_key => role_id).count
    end

    def self.find_by_realm_id_and_role_id(realm_id, role_id)
      functions = []
      DB.connect.fetch("select function_key, function_name from " +
                       "sakai_realm_function where function_key in " +
                       "(select function_key from sakai_realm_rl_fn " +
                       "where realm_key=? and role_key=?) " +
                       "order by function_name", realm_id, role_id) do |row|
        function_id = row[:function_key].to_i.to_s
        function_name = row[:function_name]
        functions << AuthzFunction.new(function_id, function_name)
      end
      functions
    end
  end

  class AuthzRealm < SakaiObject
    attr_reader :name, :providers, :maintain_role

    def initialize(id, name, providers, maintain_role)
      @id = id
      @name = name
      if providers.nil?
        @providers = nil
      else
        @providers = providers.split("+")
      end
      @maintain_role = maintain_role
    end

    def realm_roles
      @realm_roles ||= AuthzRealmRole.find_by_realm_id(@id)
    end

    def to_s
      name
    end

    def user_count
      @user_count ||= AuthzRealmMembership.count_by_realm_id(@id)
    end

    def membership
      @membership ||= AuthzRealmMembership.find_by_realm_id(@id)
    end

    @@cache = {}
    def self.find_by_id(id)
      id = id.to_s
      if @@cache[id].nil?
        row = DB.connect.exec("select realm_id, provider_id, maintain_role " +
                              "from sakai_realm " +
                              "where realm_key = ?", id.to_i).first
        if row.nil?
          raise ObjectNotFoundException.new(AuthzRealm, id)
        end

        name = row[:realm_id]
        providers = row[:provider_id]
        maintain_role = nil
        if row[:maintain_role].nil? or row[:maintain_role] == ""
          maintain_role = nil
        else
          maintain_role = AuthzRole.find_by_id(row[:maintain_role].to_i)
        end
        @@cache[id] = AuthzRealm.new(id, name, providers, maintain_role)
        @@cache[name] = @@cache[id]
      end
      @@cache[id]
    end

    def self.find_by_name(name)
      if @@cache[name].nil?
        row = DB.connect.exec("select realm_key, provider_id, maintain_role " +
                              "from sakai_realm " +
                              "where realm_id = ?", name).first
        if row.nil?
          raise ObjectNotFoundException.new(AuthzRealm, name)
        end

        id = row[:realm_key].to_i.to_s
        providers = row[:provider_id]
        maintain_role = nil
        if row[:maintain_role].nil? or row[:maintain_role] == ""
          maintain_role = nil
        else
          maintain_role = AuthzRole.find_by_id(row[:maintain_role].to_i)
        end
        @@cache[name] = AuthzRealm.new(id, name, providers, maintain_role)
        @@cache[id] = @@cache[name]
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

    def self.find_by_site_id(site_id)
      AuthzRealm.find_by_name("/site/#{site_id}")
    end

    def self.find_by_site_id_and_group_id(site_id, group_id)
      AuthzRealm.find_by_name("/site/#{site_id}/group/#{group_id}")
    end
  end

  class AuthzRealmRole < SakaiObject
    attr_reader :realm, :role

    def initialize(realm, role)
      @realm = realm
      @role = role
    end

    def function_count
      @function_count ||= AuthzFunction.count_by_realm_id_and_role_id(@realm.id, @role.id)
    end

    def functions
      @functions ||= AuthzFunction.find_by_realm_id_and_role_id(@realm.id, @role.id)
    end

    def user_count
      @user_count ||= User.count_by_realm_id_and_role_id(@realm.id, @role.id)
    end

    def users
      @users ||= User.find_by_realm_id_and_role_id(@realm.id, @role.id)
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
        "function_count" => self.function_count
      }
    end

    def summary_serialization
      {
        "role_name" => self.role.name,
        "user_count" => self.user_count,
        "function_count" => self.function_count
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
      DB.connect[:sakai_realm_rl_gr].filter(:realm_key => realm_id).count
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
  end
end

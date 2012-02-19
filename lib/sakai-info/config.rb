# sakai-info/config.rb
#   SakaiInfo::Config library
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-19 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class NoConfigFoundException < SakaiException; end
  class AlreadyConfiguredException < SakaiException; end
  class InvalidInstanceNameException < SakaiException; end
  class InvalidConfigException < SakaiException; end
  class UnsupportedConfigException < InvalidConfigException; end
  class MultipleConfigException < InvalidConfigException
    def initialize
      @exceptions = []
    end

    def add(instance_name, exception)
      @exceptions << [instance_name, exception]
    end

    def count
      @exceptions.length
    end

    def message
      "Multiple config exceptions were found:\n  " +
        @exceptions.collect{ |e| "#{e[0]}: #{e[1].message}" }.join("\n  ")
    end
  end

  # config format assumptions:
  #   a YAML string containing one of the following options:
  #     - a single database connection spec
  #     - eg:
  #         ---
  #         dbtype: oracle
  #         dbsid: PROD
  #         username: sakai
  #         password: Sekrit1
  #   OR:
  #     - an "instances" key containing a hash of named connection specs
  #     - with a "default" key naming the spec to use if none is specified
  #     - eg:
  #         ---
  #         default: production
  #         instances:
  #           production:
  #             dbtype: oracle
  #             service: PROD
  #             username: sakai
  #             password: prodpass
  #           test:
  #             dbtype: oracle
  #             service: TEST
  #             host: testdb.host
  #             port: 1521
  #             username: sakai
  #             password: testpass
  #           dev:
  #             dbtype: mysql
  #             host: dbserver.hostname.int
  #             port: 3306
  #             username: sakai
  #             password: ironchef
  #             dbname: sakaidev
  #           localdev:
  #             dbtype: mysql
  #             host: localhost
  #             port: 3306
  #             username: sakai
  #             password: ironchef
  #             dbname: sakailocal
  #
  #
  # NOTES:
  #  - Oracle connections should use either an alias defined in the
  #    driver's tnsnames.ora file, or specify the host and port as the
  #    test instance example above does
  #
  class Config
    @@config = nil

    # validate just a single database connection configuration hash
    def self.validate_single_connection_config(config)
      if config.nil?
        raise InvalidConfigException.new("The config provided was nil")
      end

      if not config.is_a? Hash
        raise InvalidConfigException.new("The config provided must be a Hash")
      end

      # we have to have a dbtype value or we can't validate
      if config["dbtype"].nil?
        raise InvalidConfigException.new("The config does not specify 'dbtype'")
      end

      # force lowercase to simplify comparisons
      dbtype = config["dbtype"].downcase

      if not %w(oracle mysql).include? dbtype
        raise UnsupportedConfigException.new("Database type '#{dbtype}' is not supported.")
      end

      # now check per-dbtype requirements
      if dbtype == "oracle"
        %w(service username password).each do |required_key|
          if config[required_key].nil? or config[required_key] == ""
            raise InvalidConfigException.new("Oracle config requires values for 'service', 'username', and 'password'.")
          end
        end
      elsif dbtype == "mysql"
        %w(host username password dbname).each do |required_key|
          if config[required_key].nil? or config[required_key] == ""
            raise InvalidConfigException.new("MySQL config requires values for 'host', 'username', 'password', and 'dbname'.")
          end
        end
      else
        # we should never have made it here
        raise UnsupportedConfigException.new("Database type '#{dbtype}' is not supported.")
      end

      # for both types, 'port' is optional but if it exists it must be a valid TCP port
      if not config["port"].nil?
        begin
          port = config["port"].to_i
          if port < 1 or port > 65535
            raise
          end
        rescue
          raise InvalidConfigException.new("Config value 'port' must be a valid TCP port number.")
        end
      end

      # if we made it here the config is complete and well-formed
      return true
    end

    # validate that configuration is complete and well-formed
    def self.validate_config(config)
      if config.nil?
        raise InvalidConfigException.new("The config provided was nil")
      end

      if not config.is_a? Hash
        raise InvalidConfigException.new("The config provided must be a Hash")
      end

      # if 'dbtype' exists, it will be a single database configuration
      if config["dbtype"]
        self.validate_single_connection_config(config)
      else
        # otherwise both 'default' and 'instances' keys are required
        if config.keys.sort != ["default","instances"]
          raise InvalidConfigException.new("The config must specify either 'dbtype' or both 'default' and 'instances'.")
        end

        # enforce types on the values of 'default' and 'instances'
        if not config["default"].is_a? String
          raise InvalidConfigException.new("The value of 'default' must be a String.")
        end
        if not config["instances"].is_a? Hash
          raise InvalidConfigException.new("The value of 'instances' must be a Hash.")
        end

        # 'default' must be a string pointing to one of the 'instances' keys
        if not config["instances"].keys.include? config["default"]
          raise InvalidConfigException.new("The default instance '#{config["default"]}' was not among the instance names given: #{config["instances"].keys.inspect}")
        end

        # check the validity of each instance, collecting exceptions as we go
        multi_exceptions = nil
        config["instances"].keys.each do |instance_name|
          begin
            self.validate_single_connection_config(config["instances"][instance_name])
          rescue InvalidConfigException => e
            # create the object if it doesn't already exist
            multi_exceptions ||= MultipleConfigException.new

            # add this exception to the list
            multi_exceptions.add(instance_name, e)
          end
          # continue the loop no matter what
        end

        # if this object was created, the exception needs to be raised
        if not multi_exceptions.nil?
          raise multi_exceptions
        end
      end

      # if we've made it this far, the configuration must be fine
      return true
    end

    def initialize(config)
      begin
        if config.is_a? Hash
          @config = config
        elsif config.is_a? String and File.exist?(config)
          # try to parse as a filename first
          if File.exist?(config)
            @config = YAML::load_file(config)
          end
        else
          # otherwise try to parse it generically
          @config = YAML::load(config)
        end
      rescue Exception => e
        raise InvalidConfigException.new("Unable to parse configuration: #{e}")
      end

      # check that the configuration specified is well formed
      if not Config::validate_config(@config)
        raise InvalidConfigException.new("Config provided is either incomplete or poorly formed.")
      end

      # create instance objects
      @instances = {}
      if not @config["instances"].nil?
        @config["instances"].keys.each do |instance_name|
          @instances[instance_name] = Instance.create(@config["instances"][instance_name])
          if instance_name == @config["default"]
            @instances[:default] = @instances[instance_name]
          end
        end
      else
        @instances[:default] = Instance.create(@config)
      end
    end

    # instance accessibility
    def get_instance(instance_name)
      @instances[instance_name] or raise InvalidInstanceNameException
    end

    def default_instance
      @instances[:default]
    end

    DEFAULT_CONFIG_FILE = "~/.sakai-info"
    # check to see if configuration file exists
    # by default ~/.sakai-info
    def self.config_file_path
      if File.readable? DEFAULT_CONFIG_FILE
        DEFAULT_CONFIG_FILE
      else
        nil
      end
    end

    # are we already configured?
    def self.configured?
      not @@config.nil?
    end

    # load configuration as a class variable (and return it as well)
    def self.load_config(alternate_config_file = nil)
      if Config.configured?
        raise AlreadyConfiguredException
      end

      unless(config_file = alternate_config_file || Config.config_file_path)
        raise NoConfigFoundException
      end

      @@config = Config.new(config_file)
    end

    # return specified database connection configuration
    def self.get_instance(instance_name = nil)
      Config.load_config unless Config.configured?

      if instance_name.nil?
        @@config.default_instance
      else
        @@config.get_instance(instance_name)
      end
    end
  end
end


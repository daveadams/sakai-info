# sakai-info/config.rb
#   SakaiInfo::Config library
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-18 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
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
  #             dbsid: PROD
  #             username: sakai
  #             password: prodpass
  #           test:
  #             dbtype: oracle
  #             dbsid: TEST
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
  #  - TODO: For this release MySQL connections are not supported
  #  - Oracle connections assume the use of tnsnames.ora file that
  #    can be found by the Ruby oci8 driver. The dbsid property
  #    is intended to be the service name as defined in tnsnames.ora.
  #
  class Config
    attr_reader :config

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

      # TODO: when MySQL support is added, remove special MySQL warning
      # give a hopeful message for MySQL
      if dbtype == "mysql"
        raise UnsupportedConfigException.new("MySQL is not yet supported, but will be soon.")
      end

      # TODO: when MySQL support is added, add mysql to supported list
      # if not %w(oracle mysql).include? dbtype
      if not %w(oracle).include? dbtype
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
        %(host username password dbname).each do |required_key|
          if config[required_key].nil? or config[required_key] == ""
            raise InvalidConfigException.new("MySQL config requires values for 'host', 'username', 'password', and 'dbname'.")
          end
        end

        # 'port' is optional (defaults to 3306), but if it exists it must be a valid port number
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
      else
        # we should never have made it here
        raise UnsupportedConfigException.new("Database type '#{dbtype}' is not supported.")
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

      if not Config::validate_config(@config)
        raise InvalidConfigException.new("Config provided is either incomplete or poorly formed.")
      end
    end
  end
end


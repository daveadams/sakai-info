# sakai-info/database.rb
#   SakaiInfo::Database library
#
# Created 2012-02-19 daveadams@gmail.com
# Last updated 2012-02-25 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

# DATABASE CONFIG FORMAT
#
# yaml file with lines of "nickname: sequel-connection-string", eg:
#
#   prod: oracle://user:pass@sid
#   test: oracle://user:pass@sid/schema_name
#   dev: mysql://user:pass@hostname/db_name
#
# The default connection is the first one in the file.
# For more on Sequel connection strings, see:
#   http://sequel.rubyforge.org/rdoc/files/doc/opening_databases_rdoc.html
#

# using the oci8 driver will complain if NLS_LANG is not set in the environment
ENV["NLS_LANG"] ||= "AMERICAN_AMERICA.UTF8"

module SakaiInfo
  class InvalidConfigException < SakaiException; end
  class ConnectionFailureException < SakaiException; end

  class DB
    DEFAULT_CONFIG_FILE = File.expand_path("~/.sakai-info")
    @@default_database_name = nil
    @@config = nil

    def self.configure(config)
      begin
        if config.is_a? Hash
          @@config = config
        elsif config.is_a? String and File.exist?(config)
          # try to parse as a filename first
          if File.exist?(config)
            @@config = YAML::load_file(config)
          end
        else
          # otherwise try to parse it generically
          @@config = YAML::load(config)
        end
      rescue Exception => e
        raise InvalidConfigException.new("Unable to parse configuration: #{e}")
      end
    end

    def self.load_config
      if File.readable? DEFAULT_CONFIG_FILE
        DB.configure(DEFAULT_CONFIG_FILE)
      else
        raise MissingConfigException.new("No config file found at #{DEFAULT_CONFIG_FILE}")
      end
    end

    def self.databases
      @@config
    end

    @@databases = {}
    def self.connect(database_name = :default)
      if @@config.nil?
        DB.load_config
      end
      if @@databases[database_name].nil?
        @@databases[database_name] =
          Database.new(if database_name == :default
                         if @@default_database_name.nil?
                           @@config[@@config.keys.first]
                         else
                           @@config[@@default_database_name]
                         end
                       else
                         @@config[database_name]
                       end,
                       @@logger)
      end
      @@databases[database_name].connect
    end

    def self.default_database=(database_name)
      @@default_database_name = database_name
    end

    # set global logger
    @@logger = nil
    def self.logger=(logger)
      @@logger = logger

      # also force it on any existing database connections
      @@databases.each do |name, dbconn|
        puts "updating #{name}"
        puts dbconn.class
        dbconn.logger = @@logger
        puts dbconn.connect.loggers.inspect
      end
    end
  end

  class Database
    def initialize(connection_string, logger = nil)
      @connection_string = connection_string.to_s
      @logger = logger
    end

    def connect
      if @connection and self.alive?
        return @connection
      end

      begin
        @connection = Sequel.connect(@connection_string)
      rescue => e
        @connection = nil
        raise ConnectionFailureException.new("Could not connect: #{e}")
      end

      if not @logger.nil?
        @connection.logger = @logger
      end

      return @connection
    end

    def logger=(logger)
      @logger = logger
      @connection.logger = @logger
    end

    def alive?
      (not @connection.nil?) && @connection.test_connection
    end
  end
end

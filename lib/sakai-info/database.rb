# sakai-info/database.rb
#   SakaiInfo::Database library
#
# Created 2012-02-19 daveadams@gmail.com
# Last updated 2012-10-13 daveadams@gmail.com
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
# For connections requiring options not well-supported by URI strings,
#   i.e. passwords with special characters, or non-default schemas,
#   all options can be specified one their own line, eg:
#
#   lmssbx:
#     adapter: oracle
#     user: user
#     password: pas^w#?d
#     host: db_name
#     after_connect: ALTER SESSION SET CURRENT_SCHEMA=sakai
#
# Some connections may require a query be run immediately after connecting, i.e.
#   to select a default schema. Sequel supports this through the after_connect
#   option. To provide a query for after_connect, include it as shown above.
#
# The default connection is the first one in the file.
# For more on Sequel connection strings, see:
#   http://sequel.rubyforge.org/rdoc/files/doc/opening_databases_rdoc.html
#
# As an alternative, may specify an alternate file name by putting an @ sign
# followed by the filename to load the config from on the first line of
# the config file specified, eg:
#
#   @/etc/sakai-info/shared.conf
#

# using the oci8 driver will complain if NLS_LANG is not set in the environment
ENV["NLS_LANG"] ||= "AMERICAN_AMERICA.UTF8"

module SakaiInfo
  class InvalidConfigException < SakaiException; end
  class MissingConfigException < SakaiException; end
  class ConnectionFailureException < SakaiException; end

  class DB
    DEFAULT_CONFIG_FILE = File.expand_path("~/.sakai-info")
    @@default_database_name = nil
    @@config = nil
    @@config_file = DEFAULT_CONFIG_FILE

    def self.config_file=(newfile)
      @@config_file = newfile
    end

    def self.config_file
      @@config_file
    end

    def self.configure(config)
      begin
        if config.is_a? Hash
          @@config = config
        elsif config.is_a? String and File.exist?(config)
          # try to parse as a filename first
          # first check to see if it points to a different config file
          File.open(config) do |f|
            first_line = f.readlines[0].chomp
            if first_line =~ /^@(.+)$/
              # use the rest of the line as an alternate filename
              config = $1
            end
          end
          if File.exist?(config)
            @@config = YAML::load_file(config)
            # loop through each connection, symbolicize keys in options hashes
            @@config.each do |name,connect_info|
              if connect_info.is_a?(Hash)
                conn = {}
                connect_info.each do |option,value|
                  osym=option.to_sym
                  # If a query is needed after connection, store it in a procedure
                  # See: http://sequel.rubyforge.org/rdoc/files/doc/release_notes/3_11_0_txt.html
                  if option=="after_connect"
                    conn[osym]=proc{|c| c.exec(value)}
                  else
                    conn[osym]=value
                  end
                end
                @@config[name]=conn
              end
            end
          else
            raise "No such file '#{config}'"
          end
        else
          # otherwise try to parse it generically
          @@config = YAML::load(config)
        end
      rescue Exception => e
        raise InvalidConfigException.new("Unable to parse configuration: #{e}")
      end
    end

    def self.load_config(config_file = DB.config_file)
      if File.readable? config_file
        DB.configure(config_file)
      else
        raise MissingConfigException.new("No config file found at #{config_file}")
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
      # spin it up so that we throw a missing config exception if it's invalid
      DB.connect(@@default_database_name)
      @@default_database_name
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
    def initialize(connect_info, logger = nil)
      if connect_info.nil?
        raise MissingConfigException.new("No configuration was provided")
      end
      @connect_info = connect_info
      @logger = logger
    end

    def connect
      if @connection and self.alive?
        return @connection
      end

      begin
        @connection = Sequel.connect(@connect_info)
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

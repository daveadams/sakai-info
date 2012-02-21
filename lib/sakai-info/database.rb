# sakai-info/database.rb
#   SakaiInfo::Instance library
#
# Created 2012-02-19 daveadams@gmail.com
# Last updated 2012-02-21 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class ConnectionFailureException < SakaiException; end
  class InvalidDriverException < SakaiException; end

  class DB
    def self.connect(instance_name = :default)
      Database.connect(instance_name)
    end
  end

  class Database
    def self.connect(instance_name = :default)
      Configuration.get_instance(instance_name).connect
    end

    @@drivers = {}
    def self.register_driver(driver_name, driver_class)
      if not driver_class.is_a? Class
        raise InvalidDriverException.new("Driver '#{driver_name}' did not supply the driver Class.")
      end

      if not driver_class.ancestors.include? DatabaseDriver
        raise InvalidDriverException.new("Driver '#{driver_name}' class of '#{driver_class}' is not correctly defined.")
      end

      @@drivers[driver_name] = driver_class
    end

    def self.avialable_drivers
      @@drivers.keys.sort
    end

    attr_reader :driver

    def initialize(config)
      dbtype = config["dbtype"].downcase
      if @@drivers.has_key? dbtype
        @driver = @@drivers[dbtype].new(config)
      else
        raise UnsupportedConfigException.new("Database type '#{dbtype}' is not supported.")
      end
    end
  end

  class DatabaseDriver
    def initialize(config)
      @config = config
    end

    def dbtype
      ""
    end

    def alive?
      false
    end

    def connect
      raise UnsupportedConfigException.new("'#{self.dbtype}' connections are not supported.")
    end
  end

  class OracleDriver < DatabaseDriver
    DEFAULT_PORT = 1521

    def initialize(config)
      @username = config["username"]
      @password = config["password"]
      if config["host"].nil? or config["host"] == ""
        @service = config["service"]
      else
        @host = config["host"]
        @port = config["port"].nil? ? DEFAULT_PORT : config["port"].to_i
        @service = "//#{@host}:#{@port}/#{config["service"]}"
      end

      # close the connection upon exit
      at_exit {
        if @connection
          begin
            if @connection.methods.include? :ping
              @connection.logoff if @connection.ping
            else
              @connection.logoff
            end
          rescue
            # it's ok
          end
        end
      }
    end

    def dbtype
      "oracle"
    end

    def alive?
      is_alive = false
      begin
        @connection.exec("select 1 from dual") do |row|
          if row[0] == 1
            is_alive = true
          end
        end
      rescue
        # doesn't matter what the exception is
        @connection = nil
        is_alive = false
      end

      is_alive
    end

    def connect
      if @connection and self.alive?
        return @connection
      end

      begin
        @connection = OCI8.new(@username, @password, @service)
      rescue => e
        @connection = nil
        raise ConnectionFailureException.new("Could not connect: #{e}")
      end
    end
  end

  # check for Oracle driver
  begin
    # fix NLS_LANG if necessary
    ENV["NLS_LANG"] ||= "AMERICAN_AMERICA.UTF8"

    # include Oracle driver
    require 'oci8'

    # if that worked, the Oracle driver is available
    Database.register_driver("oracle", OracleDriver)

  rescue LoadError
    # no need to do anything here
  end


  class MySqlDriver < DatabaseDriver
    DEFAULT_PORT = 3306

    def initialize(config)
      @username = config["username"]
      @password = config["password"]
      @dbname = config["dbname"]
      @host = config["host"]
      @port = config["port"].nil? ? 3306 : config["port"].to_i
    end

    def dbtype
      "mysql"
    end

    def alive?
      false
    end

    def connect
    end
  end

  # check for MySQL driver
  begin
    # include mysql driver
    require 'mysql'

    # if that worked, the MySQL driver is available
    Database.register_driver("mysql", MySqlDriver)

  rescue LoadError
    # no need to do anything here
  end


  class SqliteDriver < DatabaseDriver
    def dbtype
      "sqlite"
    end
  end
  # check for Sqlite driver and try to register
  begin
    # include sqlite driver
    require 'sqlite3'

    # if that worked, the Sqlite driver is available
    Database.register_driver("sqlite", SqliteDriver)

  rescue LoadError
    # no need to do anything here
  end
end

# sakai-info/instance.rb
#   SakaiInfo::Instance library
#
# Created 2012-02-19 daveadams@gmail.com
# Last updated 2012-02-19 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Instance
    def self.create(config)
      case config["dbtype"].downcase
      when "oracle" then
        OracleInstance.new(config)
      when "mysql" then
        MySqlInstance.new(config)
      else
        raise UnsupportedConfigException.new("Database type '#{config["dbtype"]}' is not supported.")
      end
    end
  end

  class OracleInstance
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

  class MySqlInstance
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
      raise UnsupportedConfigException.new("MySQL will be supported in a future release.")
    end
  end
end

# sakai-info/config.rb
#   SakaiInfo::Config library
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-15 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class InvalidConfigException < ScholarException; end
  class Config
    attr_reader :config

    # validate that configuration is complete and well-formed
    def self.validate_config(config)
      return false if config.nil? or not config.is_a? Hash

      # check for required keys
      %w(dbtype dbuser dbpass).each do |key|
        if config[key].nil?
          return false
        end
      end

      # check for valid database type
      if not ( config["dbtype"] == "mysql" or config["dbtype"] == "oracle" )
        return false
      end

      # check for mysql specific keys
      if config["dbtype"] == "mysql"
        %w(dbname dbhost dbport).each do |key|
          if config[key].nil?
            return false
          end
        end
      end

      # check for oracle specific keys
      if config["dbtype"] == "oracle"
        if config["dbsid"].nil?
          return false
        end
      end

      # if we made it here the config is complete and well-formed
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


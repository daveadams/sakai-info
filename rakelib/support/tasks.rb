# tasks.rb
#   task definitions for project support
#
# Created 2012-02-27 daveadams@gmail.com
# Last updated 2012-02-27 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'yaml'
require File.join(File.dirname(__FILE__), 'schema_info')

# using the oci8 driver will complain if NLS_LANG is not set in the environment
ENV["NLS_LANG"] ||= "AMERICAN_AMERICA.UTF8"

namespace :schema do
  desc "Create schema dump directory"
  task :create_dir do
    print "Creating directory for schema creation files... "; STDOUT.flush
    system "mkdir -p #{Support::SchemaInfo::DumpDir}"
    puts "OK"
  end

  desc "Remove schema creation files"
  task :clean do
    print "Deleting any old schema creation files... ";STDOUT.flush
    n = File.delete(*Dir[File.join(Support::SchemaInfo::DumpDir, "create_*.rb")])
    puts "#{n} files deleted"
  end

  desc "Dump schema creation files"
  task :dump, [:db] => [:create_dir, :clean] do |t, args|
    args.with_defaults(:db => :default)

    ConfigFile = File.expand_path("~/.sakai-info")
    config = nil
    if File.exist? ConfigFile
      begin
        config = YAML::load_file(ConfigFile)
      rescue
      end
    end

    connection_string = if not config.nil?
                          if args[:db] == :default
                            # none specified--use the first entry in the file
                            config.values[0]
                          else
                            config[args[:db]]
                          end
                        else
                          # interpret the argument as a literal connection string
                          args[:db]
                        end

    # now set up Sequel
    require 'sequel'
    Sequel.extension(:schema_dumper)

    # and try to connect
    db = nil
    begin
      db = Sequel.connect(connection_string)
    rescue => e
      if args[:db] == :default
        STDERR.puts "Could not connect to default database"
      else
        STDERR.puts "Could not connect to database '#{args[:db]}'"
      end
      STDERR.puts "  #{e}"
      exit 1
    end

    puts "Dumping schema creation files to disk:"
    Support::SchemaInfo.tables.each do |table|
      print "  Dumping table #{table}... ";STDOUT.flush
      File.open(File.join(Support::SchemaInfo::DumpDir, "create_#{table}.rb"), "w") do |f|
        f.write(db.dump_table_schema(table).each_line.collect do |line|
                  line.chomp!
                  if line =~ /^  primary_key / and line =~ /:type=>(String|BigDecimal)/
                    line + ", :auto_increment=>false"
                  else
                    line
                  end
                end.join("\n"))
      end
      puts "OK"
    end
  end
end

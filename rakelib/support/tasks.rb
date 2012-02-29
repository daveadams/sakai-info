# tasks.rb
#   task definitions for project support
#
# Created 2012-02-27 daveadams@gmail.com
# Last updated 2012-02-29 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'yaml'
require File.join(File.dirname(__FILE__), 'schema_info')
require File.join(File.dirname(__FILE__), 'doc_tasks')

# using the oci8 driver will complain if NLS_LANG is not set in the environment
ENV["NLS_LANG"] ||= "AMERICAN_AMERICA.UTF8"

def db_connect(connection_name = :default)
  config_file = File.expand_path("~/.sakai-info")
  config = nil
  if File.exist? config_file
    begin
      config = YAML::load_file(config_file)
    rescue
    end
  end

  connection_string = if not config.nil?
                        if connection_name == :default
                          # none specified--use the first entry in the file
                          config.values[0]
                        else
                          config[connection_name]
                        end
                      else
                        # interpret the argument as a literal connection string
                        args[:db]
                      end

  # now set up Sequel
  require 'sequel'

  # and try to connect
  db = nil
  begin
    db = Sequel.connect(connection_string)
  rescue => e
    if connection_name == :default
      STDERR.puts "Could not connect to default database"
    else
      STDERR.puts "Could not connect to database '#{connection_name}'"
    end
    STDERR.puts "  #{e}"
    exit 1
  end

  return db
end


namespace :schema do
  task :create_schema_dir do
    print "Creating directory for schema creation files... "; STDOUT.flush
    system "mkdir -p #{Support::SchemaInfo::DumpDir}"
    puts "OK"
  end

  task :clean_schema do
    print "Deleting any old schema creation files... ";STDOUT.flush
    n = File.delete(*Dir[File.join(Support::SchemaInfo::DumpDir, "create_*.rb")])
    puts "#{n} files deleted"
  end

  desc "Dump schema creation files"
  task :dump, [:db] => [:create_schema_dir, :clean_schema] do |t, args|
    args.with_defaults(:db => :default)

    db = db_connect(args[:db])
    Sequel.extension(:schema_dumper)

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

  task :create_testdb_dir do
    print "Creating directory for test database... "; STDOUT.flush
    system "mkdir -p #{Support::SchemaInfo::TestDbDir}"
    puts "OK"
  end

  task :clean_testdb do
    print "Deleting test database... "; STDOUT.flush
    system "rm -f #{Support::SchemaInfo::TestDbFile}"
    puts "OK"
  end

  desc "Create test DB"
  task :testdb => [:create_testdb_dir, :clean_testdb] do
    require 'sequel'
    db = Sequel.sqlite(Support::SchemaInfo::TestDbFile)

    puts "Initializing test database:"
    Dir["#{Support::SchemaInfo::DumpDir}/create_*.rb"].each do |filename|
      table = File.basename(filename, ".rb").sub(/^create_/,"")
      print "  Creating table #{table}... ";STDOUT.flush
      File.open(filename) do |f|
        db.instance_eval(f.read)
      end
      puts "OK"
    end
  end
end

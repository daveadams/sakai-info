# tasks.rb
#   task definitions for project support
#
# Created 2012-02-27 daveadams@gmail.com
# Last updated 2012-05-20 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'yaml'
require File.join(File.dirname(__FILE__), 'schema_info')
require File.join(File.dirname(__FILE__), 'doc_tasks')
require File.join(File.dirname(__FILE__), 'raw_data')

require 'sequel'
require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'sakai-info', 'exceptions')
require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'sakai-info', 'hacks')
require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'sakai-info', 'database')

def db_connect(connection_name = :default)
  SakaiInfo::DB.connect(connection_name)
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
    db = Sequel.sqlite(Support::SchemaInfo::TestDbFile)

    puts "Initializing test database schema:"
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

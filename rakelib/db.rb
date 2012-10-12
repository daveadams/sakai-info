# db.rb
#   database-related rake tasks
#
# Created 2012-10-12 daveadams@gmail.com
# Last updated 2012-10-12 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

TESTDBDIR = File.join(TMPDIR, 'db')
TESTDBFILE = File.join(TESTDBDIR, 'test.db')

namespace :db do
  namespace :test do
    desc "(Re)Initialize local sqlite test database"
    task :init => ["schema:dump","data:generate"] do
      if not File.exist? TESTDBDIR
        print "Creating directory for test database... "; STDOUT.flush
        system "mkdir -p #{TESTDBDIR}"
        puts "OK"
      end

      if File.exist? TESTDBFILE
        print "Deleting test database... "; STDOUT.flush
        system "rm -f #{TESTDBFILE}"
        puts "OK"
      end

      db = Sequel.sqlite(TESTDBFILE)

      puts "Initializing test database schema:"
      Dir["#{SCHEMADUMPDIR}/create_*.rb"].each do |filename|
        table = File.basename(filename, ".rb").sub(/^create_/,"")
        print "  Creating table #{table}... ";STDOUT.flush
        File.open(filename) do |f|
          db.instance_eval(f.read)
        end
        puts "OK"
      end

      Dir["#{FIXTUREDIR}/*.yml"].each do |filename|
        table = File.basename(filename, ".yml")
        print "Loading fixtures for #{table}...";STDOUT.flush
        fixtures = YAML::load_file(filename)

        fixtures.each do |fixture|
          print ".";STDOUT.flush
          db[table.to_sym].insert(fixture)
        end
        puts "OK"
      end
    end
  end
end


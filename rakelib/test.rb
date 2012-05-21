# test.rb
#   test-related rake tasks
#
# Created 2012-05-21 daveadams@gmail.com
# Last updated 2012-05-21 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

# standard unit tests
require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << 'test'
end

# db-test related
TESTDBDIR = File.join(TMPDIR, 'db')
TESTDBFILE = File.join(TESTDBDIR, 'test.db')

namespace :db do
  task :create_testdb_dir do
    print "Creating directory for test database... "; STDOUT.flush
    system "mkdir -p #{TESTDBDIR}"
    puts "OK"
  end

  task :clean_testdb do
    print "Deleting test database... "; STDOUT.flush
    system "rm -f #{TESTDBFILE}"
    puts "OK"
  end

  namespace :create do
    desc "Create test DB"
    task :test => [:create_testdb_dir, :clean_testdb] do
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
    end
  end
end


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


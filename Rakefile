# Rakefile
#   rake definitions
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-16 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'lib/sakai-info/version'

GEM_NAME = "sakai-info"
GEM_FULLNAME = "#{GEM_NAME}-#{SakaiInfo::VERSION}"
GEM_FILENAME = "#{GEM_FULLNAME}.gem"

namespace :gem do
  desc "Build the gem file sakai-info-#{GEM_FILENAME}"
  task :build => :test do
    system "gem build sakai-info.gemspec"
  end

  desc "Install #{GEM_FILENAME} in your local rubygems library"
  task :install => :build do
    system "sudo gem install #{GEM_FILENAME}"
  end

  # desc "Upload built gem to RubyForge"
  # task :release => :build do
  #   system "gem push #{GEM_FULLNAME}"
  # end
end

# standard unit tests
require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << 'test'
end

# make the default task to run tests
desc "By default, rake will run tests"
task :default => :test


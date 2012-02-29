# Rakefile
#   rake definitions
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-27 daveadams@gmail.com
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
    system "sudo gem install #{GEM_FILENAME} --no-rdoc --no-ri"
  end

  desc "Remove #{GEM_NAME} gem from your local rubygems library"
  task :uninstall do
    system "sudo gem uninstall #{GEM_NAME}"
  end

  desc "Upload built gem to RubyForge"
  task :release => :build do
    system "gem push #{GEM_FILENAME}"
  end
end

desc "Find and print all TODO annotations"
task :todo do
  system "for FILE in $(grep -rl TODO: * --exclude=Rakefile); do echo $FILE; cat -n $FILE |grep TODO: |sed 's/^ *\\([0-9]\\+\\).*TODO:/  \\1- TODO:/' ; echo; done |sed '$d'"
end

desc "Delete built gemfiles, tmp, and doc"
task :clean do
  system "rm -f sakai-info-*.gem"
  system "rm -rf tmp/"
  system "rm -rf doc/"
end

# include external support tasks
require File.expand_path(File.join(File.dirname(__FILE__), "rakelib", "support", "tasks"))

# standard unit tests
require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << 'test'
end

# make the default task to run tests
desc "By default, rake will run tests"
task :default => :test


# Rakefile
#   rake definitions
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-15 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << 'test'
end

require 'lib/sakai-info/version'
task :build => :test do
  system "gem build sakai-info.gemspec"
end

# task :release => :build do
#   system "gem push sakai-info-#{SakaiInfo::VERSION}"
# end


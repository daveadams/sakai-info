# gem.rb
#   gem-related rake tasks
#
# Created 2012-05-21 daveadams@gmail.com
# Last updated 2012-05-21 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

GEM_NAME = "sakai-info"
GEM_FULLNAME = "#{GEM_NAME}-#{SakaiInfo::VERSION}"
GEM_FILENAME = "#{GEM_FULLNAME}.gem"
GEMSPEC = File.join(BASEDIR, "#{GEM_NAME}.gemspec")

namespace :gem do
  desc "Build the gem file #{GEM_FILENAME}"
  task :build => :test do
    system "gem build #{GEMSPEC}"
  end

  desc "Upload built gem to RubyForge"
  task :release => :build do
    system "gem push #{GEM_FILENAME}"
  end
end

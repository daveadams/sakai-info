# db.rb
#   database-related rake tasks
#
# Created 2012-05-21 daveadams@gmail.com
# Last updated 2012-05-21 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

namespace :db do
  desc "List database tables used in the code"
  task :tables do
    # TODO: find a non-linux way to make this list
    system "grep -hroE 'DB.connect\[:[a-z_]+\]' lib/sakai-info " +
      "|cut -d: -f2 |cut -d']' -f1 |sort -u"
  end
end


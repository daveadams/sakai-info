# db/tasks.rb

namespace :db do
  desc "List database tables used in the code"
  task :tables do
    system "grep -hroE 'DB.connect\[:[a-z_]+\]' lib/sakai-info " +
      "|cut -d: -f2 |cut -d']' -f1 |sort -u"
  end
end


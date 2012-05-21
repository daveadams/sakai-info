# misc.rb
#   misc rake tasks
#
# Created 2012-05-21 daveadams@gmail.com
# Last updated 2012-05-21 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

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


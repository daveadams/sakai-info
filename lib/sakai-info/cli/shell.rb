# shell.rb
#   sin shell
#
# Created 2012-10-07 daveadams@gmail.com
# Last updated 2012-10-07 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  module CLI
    class Shell
      def self.process(args, flags)
        print "sin> ";STDOUT.flush
        command = gets
        STDERR.puts "ERROR: sin shell not implemented"
        exit 1
      end
    end
  end
end


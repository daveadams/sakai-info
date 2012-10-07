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
        Shell.new.run
      end

      def initialize
        @prompt = "sin>"
      end

      def prompt
        print "#{@prompt} ";STDOUT.flush
        gets
      end

      def run
        loop {
          input = prompt

          # a ctrl-D sends nil
          break if input.nil?
          argv = input.chomp.split(/ +/)
          command = argv.shift
          case command.downcase
          when "quit"
            break
          when "exit"
            break
          else
            STDERR.puts "ERROR: unknown command '#{command}'"
          end
        }
      end
    end
  end
end


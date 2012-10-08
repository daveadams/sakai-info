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
        @context = nil
        @context_history = []
        @running = true
      end

      def context_prompt
        if @context.nil?
          "[-]"
        else
          # TODO: implement ShellContext object
          #@context.brief_name
          "[!]"
        end
      end

      def prompt
        print "sin#{context_prompt}> ";STDOUT.flush
        gets
      end

      def run
        while @running do
          input = prompt

          # a ctrl-D sends nil
          if input.nil?
            puts "exit"
            break
          end

          argv = input.chomp.split(/ +/)
          command = argv.shift.downcase
          method_name = ("_shell_command_#{command}").to_sym

          if Shell.method_defined? method_name
            self.method(method_name).call(argv)
          else
            STDERR.puts "ERROR: unknown command '#{command}'"
          end
        end

        # TODO: any additional cleanup here
      end

      def _shell_command_quit(argv)
        @running = false
      end

      alias_method :_shell_command_exit, :_shell_command_quit

      def _shell_command_count(argv)
        case argv[0].downcase
        when /^users?$/
          puts User.count
        when /^sites?$/
          puts Site.count
        else
          STDERR.puts("ERROR: unrecognized object type")
        end
      end

      def _shell_command_user(argv)
        user = nil
        begin
          user = User.find(argv[0])
        rescue ObjectNotFoundException => e
          STDERR.puts "ERROR: could not find user '#{argv[0]}'"
          STDERR.puts "       #{e}"
          return
        end

        return if user.nil?

        puts user.to_yaml(:shell)
      end

    end
  end
end


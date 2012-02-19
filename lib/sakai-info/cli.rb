# sakai-info/cli.rb
#   SakaiInfo::CLI library
#    - sakai-info command line tool support
#
# Created 2012-02-19 daveadams@gmail.com
# Last updated 2012-02-19 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class CLI
    def self.help(command = nil)
      case command
      when nil then
        STDERR.puts <<EOF
sakai-info #{VERSION}

Available commands:
  help         Prints general help
  version      Prints version

Type 'sakai-info help <command>' for help on a specific command.
EOF
      when "help" then
        STDERR.puts <<EOF
sakai-info help

  Prints usage information for other sakai-info commands, or without an
  argument it prints a list of possible commands.

  Usage: sakai-info help [<command>]
EOF
      when "version" then
        STDERR.puts <<EOF
sakai-info version

  Prints the current version of sakai-info.

  Usage: sakai-info version
EOF
      else
        STDERR.puts "ERROR: command '#{command}' was unrecognized"
        STDERR.puts
        CLI.help
        exit 1
      end
    end
  end
end


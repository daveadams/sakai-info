# sakai-info/cli/help.rb
#  - sakai-info command line help
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
    class Help
      STRINGS = {
        :default => <<EOF,
sakai-info #{VERSION}

  Usage: sakai-info [<options>] <command> [<subcommand>]

  Object commands:
    user         Print information about a user or users
    site         Print information about a site or sites

  Misc commands:
    test         Tests configured database connections
    help         Prints general help
    version      Prints version

  Options that apply to most commands:
    -D <name>
    --database=<name>
        Connect to database instance <name> as defined in ~/.sakai-info instead
        of the default (which is typically the first entry)

  Type 'sakai-info help <command>' for help on a specific command.
EOF

        "help" => <<EOF,
sakai-info help

  Usage: sakai-info help [<command>]

  Prints usage information for other sakai-info commands, or without an
  argument it prints a list of possible commands.
EOF

        "version" => <<EOF,
sakai-info version

  Usage: sakai-info version

  Prints the current version of sakai-info.
EOF

        "test" => <<EOF,
sakai-info test

  Usage: sakai-info [<options>] test

  Reads configuration and tests connecting to each database specified, or if
  a specific database is specified it will test only that connection.
EOF

        "user" => <<EOF,
sakai-info user

  Usage: sakai-info [<options>] user [<subcommand>]

  Prints information about a user or users based on the subcommand given.
EOF

        "site" => <<EOF,
sakai-info site

  Usage: sakai-info [<options>] site [<subcommand>] [<id> ...]

  Prints information about a site or sites based on the subcommands and IDs
  given.
EOF
      }

      def self.help(topic = :default, io = STDOUT)
        topic ||= :default
        if STRINGS.has_key? topic
          io.puts STRINGS[topic]
        else
          STDERR.puts "ERROR: help topic '#{topic}' was unrecognized"
          STDERR.puts
          CLI.help(:default, STDERR)
          exit 1
        end
      end
    end
  end
end


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

Object commands:
  user         Print information about a user or users
  site         Print information about a site or sites

Misc commands:
  validate     Validates configuration
  help         Prints general help
  version      Prints version

Type 'sakai-info help <command>' for help on a specific command.
EOF

        "help" => <<EOF,
sakai-info help

  Prints usage information for other sakai-info commands, or without an
  argument it prints a list of possible commands.

  Usage: sakai-info help [<command>]
EOF

        "version" => <<EOF,
sakai-info version

  Prints the current version of sakai-info.

  Usage: sakai-info version
EOF

        "validate" => <<EOF,
sakai-info validate

  Reads and validates the current configuration format. To test the actual
  database connections, use 'sakai-info test'.

  Usage: sakai-info validate
EOF

        "test" => <<EOF,
sakai-info test

  [NOT YET IMPLEMENTED]

  Reads configuration and tests connecting to each database specified, or with
  an argument, it will test only the named instance.

  Usage: sakai-info test [<instance>]
EOF

        "user" => <<EOF,
sakai-info user

  In this release, this command prints the total number of records in the
  SAKAI_USER table. In future releases, subcommands will be available to
  perform more tasks.

  Usage: sakai-info user [<subcommand>]
EOF

        "site" => <<EOF,
sakai-info site

  In this release, this command prints the total number of records in the
  SAKAI_SITE table. In future releases, subcommands will be available to
  perform more tasks.

  Usage: sakai-info site [<subcommand>]
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


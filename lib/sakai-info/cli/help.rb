# sakai-info/cli/help.rb
#  - sakai-info command line help
#
# Created 2012-02-19 daveadams@gmail.com
# Last updated 2012-03-09 daveadams@gmail.com
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

  Usage: sakai-info <command> [<id>] [<options>]

  Object commands:
    user           User information
    group          Group information

    site           Site information
    page           Site page information
    tool           Page tool information

    quiz           Quiz aka Assessment information, pending or published
    quiz-section   Quiz section information, pending or published
    quiz-item      Quiz item information, pending or published
    quiz-attempt   Quiz attempt information
    quiz-attempt-item
                   Information on attempted quiz items
    quiz-attempt-item-attachment
                   Information on file attachments to attempted quiz items

    question-pool  Question Pool information

    assignment     Assignment information
    assignment-submission
                   Assignment submission information

  Misc commands:
    test         Tests configured database connections
    help         Prints general help
    version      Prints version

  Options that apply globally:
    --database=<name>
        Connect to database instance <name> as defined in ~/.sakai-info instead
        of the default (which is typically the first entry)

    --log=<logfile>
        Log actual SQL statements to <logfile> as they are executed. Use "-"
        to log to STDOUT.

    --trace
        For development troubleshooting work, this outputs an extremely verbose
        trace log to STDOUT.

  Options that work on most object types:
    --dbrow
        Print the raw database fields in addition to the usual summary.

    --dbrow-only
        Print only the raw database fields for the object requested.

    --mod
        Print creation and modification user EIDs and timestamps.

    --mod-details
        Print creation and modification user details and timestamps.

    --all
        Print all possible information (other than dbrow)

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

  Usage: sakai-info test [<options>]

  Reads configuration and tests connecting to each database specified, or if
  a specific database is specified it will test only that connection.
EOF

        "user" => <<EOF,
sakai-info user

  Usage: sakai-info user <id> [<options>]

  Prints information about the user ID or EID specified. Additional options
  may be passed to include additional information:

    --sites    Print site membership information
    --pools    Print list of owned question pools
    --all      Print all possible details
EOF

        "group" => <<EOF,
sakai-info group

  Usage: sakai-info group <id> [<options>]

  Prints information about the group ID or EID specified. Additional options
  may be passed to include additional information:

    --users    Print user membership information
    --realm    Print corresponding realm information
    --all      Print all possible details
EOF

        "site" => <<EOF,
sakai-info site

  Usage: sakai-info site <id> [<options>]

  Prints information about the site ID specified. Additional options may be
  passed to include additional information:

    --users        Print membership information
    --pages        Print page list with tools
    --groups       Print group information
    --quizzes      Print information about quizzes
    --disk         Print disk usage
    --assignments  Print assignment info
    --gradebook    Print gradebook item info
    --realm        Print site realm details
    --forums       Print forum details
    --mod          Print creation/modification info
    --all          Print all possible details
EOF

        "page" => <<EOF,
sakai-info page

  Usage: sakai-info page <id> [<options>]

  Prints information about the page ID specified, including tools.
EOF

        "tool" => <<EOF,
sakai-info tool

  Usage: sakai-info tool <id> [<options>]

  Prints information about the tool ID specified.
EOF

        "quiz" => <<EOF,
sakai-info quiz

  Usage: sakai-info quiz <id> [<options>]

  Prints information about the quiz ID specified. The quiz ID may represent
  a pending quiz or a published quiz. Additional options may be passed to
  include additional information:

    --sections   Print section summary list
    --attempts   Print summary of user quiz attempts
    --mod        Print creation/modification info
    --all        Print all possible details

  Not yet implemented:
    --items      Print summary of items on the quiz
EOF

        "quiz-section" => <<EOF,
sakai-info quiz-section

  Usage: sakai-info quiz-section <id> [<options>]

  Prints information about the quiz section ID specified. The ID may represent
  a pending quiz section or a published quiz section. Additional options may be
  passed to include additional information:

    --items      Print summary of items in the section
    --mod        Print creation/modification info
    --all        Print all possible details
EOF

        "quiz-item" => <<EOF,
sakai-info quiz-item

  Usage: sakai-info quiz-item <id> [<options>]

  Prints information about the quiz item ID specified. The ID may represent
  a pending quiz item or a published quiz item. Additional options may be
  passed to include additional information:

    --mod        Print creation/modification info
    --all        Print all possible details
EOF

        "question-pool" => <<EOF,
sakai-info question-pool

  Usage: sakai-info qpool <id> [<options>]
         sakai-info question-pool <id> [<options>]

  Prints information about the question pool ID specified. Additional options
  may be passed to include additional information:

    --mod      Print creation/modification info

  Not yet implemented:
    --items    Print summary of items in the pool
    --quizzes  Print summary of quizzes that link to this pool
    --all      Print all possible details
EOF

        "quiz-attempt" => <<EOF,
sakai-info quiz-attempt

  Usage: sakai-info quiz-attempt <id> [<options>]

  Prints information about the quiz attempt ID specified. Additional options
  may be passed to include additional information:

    --items      Print list of attempted items
    --all        Print all possible details
EOF


        "quiz-attempt-item" => <<EOF,
sakai-info quiz-attempt-item

  Usage: sakai-info quiz-attempt-item <id> [<options>]

  Prints information about the quiz attempt item ID specified. Additional
  options may be passed to include additional information:

    --attachments  Print a list of file attachments, if any
    --all          Print all possible details
EOF

        "quiz-attempt-item-attachment" => <<EOF,
sakai-info quiz-attempt-item-attachment

  Usage: sakai-info quiz-attempt-item-attachment <id> [<options>]

  Prints information about the quiz attempt item attachment ID specified.
  Additional options may be passed to include additional information:

    --mod        Print creation/modification info
    --all        Print all possible details
EOF

        "assignment" => <<EOF,
sakai-info assignment

  Usage: sakai-info assignment <id> [<options>]

  Prints information about the assignment ID specified. Additional options
  may be passed to include additional information:

    --submissions  Print summary of all submissions
    --xml          Print the raw XML
    --mod          Print creation/modification info
    --all          Print all possible details
EOF

        "assignment-submission" => <<EOF,
sakai-info assignment-submission

  Usage: sakai-info assignment-submission <id> [<options>]

  Prints information about the assignment submission ID specified. Additional
  options may be passed to include additional information:

    --xml          Print the raw XML
    --mod          Print creation/modification info
    --all          Print all possible details
EOF
      }

      def self.help(topic = :default, io = STDOUT)
        topic ||= :default
        if STRINGS.has_key? topic
          io.puts STRINGS[topic]
        else
          STDERR.puts "ERROR: help topic '#{topic}' was unrecognized"
          STDERR.puts
          CLI::Help.help(:default, STDERR)
          exit 1
        end
      end
    end
  end
end


# sakai-info/cli/help.rb
#  - sin command line help
#
# Created 2012-02-19 daveadams@gmail.com
# Last updated 2012-10-03 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  module CLI
    class Help
      STRINGS = {
        :default => <<EOF,
Sakai INfo: sin #{VERSION}

  LOOKUP MODE
    Lookup details about a particular object and its child objects.

    Usage: sin <object-type> [<id>] [<options>]

    Supported object types:
      user, group, site, page, tool, pending-quiz, published-quiz,
      pending-quiz-section, published-quiz-section, pending-quiz-item,
      published-quiz-item, pending-quiz-access-control,
      published-quiz-access-control, quiz-attempt, quiz-attempt-item,
      quiz-attempt-item-attachment, question-pool, assignment,
      assignment-submission, forum, forum-thread, forum-post, content,
      announcement, announcement-channel, gradebook, gradebook-item,
      role, function, realm, private-message

  QUERY MODE
    Query particular fields from certain objects given certain conditions.

    Usage: sin query <object-type> [<options>]

    Use "sin help query" for more details.

  OTHER COMMANDS
    Usage: sin <command>

    Available commands:
      test             Tests configured database connections
      help             Prints general help
      version          Prints version
      help <command>   Prints help about a particular command
      help options     Prints help about additional options
EOF

        "options" => <<EOF,
Sakai Info: sin #{VERSION}
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

    --fields=f1[,f2[,...]]
        Include in output only those first-level hash keys given
EOF

        "help" => <<EOF,
sin help

  Usage: sin help [<command>]

  Prints usage information for other sin commands, or without an
  argument it prints a list of possible commands.
EOF

        "version" => <<EOF,
sin version

  Usage: sin version

  Prints the current version of sin.
EOF

        "test" => <<EOF,
sin test

  Usage: sin test [<options>]

  Reads configuration and tests connecting to each database specified, or if
  a specific database is specified it will test only that connection.
EOF

        "user" => <<EOF,
sin user

  Usage: sin user <id> [<options>]

  Prints information about the user ID or EID specified. Additional options
  may be passed to include additional information:

    --sites    Print site membership information
    --pools    Print list of owned question pools
EOF

        "group" => <<EOF,
sin group

  Usage: sin group <id> [<options>]

  Prints information about the group ID or EID specified. Additional options
  may be passed to include additional information:

    --users    Print user membership information
    --realm    Print corresponding realm information
EOF

        "site" => <<EOF,
sin site

  Usage: sin site <id> [<options>]

  Prints information about the site ID specified. Additional options may be
  passed to include additional information:

    --users         Print membership information
    --pages         Print page list with tools
    --groups        Print group information
    --quizzes       Print information about quizzes
    --disk          Print disk usage
    --assignments   Print assignment info
    --announcements Print announcement info
    --gradebook     Print gradebook item info
    --realm         Print site realm details
    --forums        Print forum details
    --mod           Print creation/modification info
EOF

        "page" => <<EOF,
sin page

  Usage: sin page <id> [<options>]

  Prints information about the page ID specified, including tools.
EOF

        "tool" => <<EOF,
sin tool

  Usage: sin tool <id> [<options>]

  Prints information about the tool ID specified.
EOF

        "pending-quiz" => <<EOF,
sin pending-quiz

  Usage: sin pending-quiz <id> [<options>]

  Prints information about the pending quiz ID specified. Additional options
  may be passed to include additional information:

    --sections   Print section summary list
    --items      Print summary of items on the quiz
    --mod        Print creation/modification info
EOF

        "published-quiz" => <<EOF,
sin published-quiz

  Usage: sin published-quiz <id> [<options>]

  Prints information about the published quiz ID specified. Additional options
  may be passed to include additional information:

    --sections   Print section summary list
    --items      Print summary of items on the quiz
    --attempts   Print summary of user quiz attempts
    --mod        Print creation/modification info
EOF

        "pending-quiz-section" => <<EOF,
sin pending-quiz-section

  Usage: sin pending-quiz-section <id> [<options>]

  Prints information about the pending quiz section ID specified. Additional
  options may be passed to include additional information:

    --items      Print summary of items in the section
    --mod        Print creation/modification info
EOF

        "published-quiz-section" => <<EOF,
sin published-quiz-section

  Usage: sin published-quiz-section <id> [<options>]

  Prints information about the published quiz section ID specified. Additional
  options may be passed to include additional information:

    --items      Print summary of items in the section
    --mod        Print creation/modification info
EOF

        "pending-quiz-item" => <<EOF,
sin pending-quiz-item

  Usage: sin pending-quiz-item <id> [<options>]

  Prints information about the pending quiz item ID specified. Additional
  options may be passed to include additional information:

    --texts      List associated pending-quiz-item-text records
    --mod        Print creation/modification info
EOF

        "published-quiz-item" => <<EOF,
sin published-quiz-item

  Usage: sin published-quiz-item <id> [<options>]

  Prints information about the published quiz item ID specified. Additional
  options may be passed to include additional information:

    --texts      List associated quiz-item-text records
    --mod        Print creation/modification info
EOF

        "pending-quiz-access-control" => <<EOF,
sin pending-quiz-access-control

  Usage: sin pending-quiz-access-control <id> [<options>]

  Prints information about the access control object attached to the
  pending quiz ID specified.
EOF

        "published-quiz-access-control" => <<EOF,
sin published-quiz-access-control

  Usage: sin published-quiz-access-control <id> [<options>]

  Prints information about the access control object attached to the
  published quiz ID specified.
EOF

        "question-pool" => <<EOF,
sin question-pool

  Usage: sin qpool <id> [<options>]
         sin question-pool <id> [<options>]

  Prints information about the question pool ID specified. Additional options
  may be passed to include additional information:

    --mod      Print creation/modification info

  Not yet implemented:
    --items    Print summary of items in the pool
    --quizzes  Print summary of quizzes that link to this pool
EOF

        "quiz-attempt" => <<EOF,
sin quiz-attempt

  Usage: sin quiz-attempt <id> [<options>]

  Prints information about the quiz attempt ID specified. Additional options
  may be passed to include additional information:

    --items      Print list of attempted items
EOF


        "quiz-attempt-item" => <<EOF,
sin quiz-attempt-item

  Usage: sin quiz-attempt-item <id> [<options>]

  Prints information about the quiz attempt item ID specified. Additional
  options may be passed to include additional information:

    --attachments  Print a list of file attachments, if any
EOF

        "quiz-attempt-item-attachment" => <<EOF,
sin quiz-attempt-item-attachment

  Usage: sin quiz-attempt-item-attachment <id> [<options>]

  Prints information about the quiz attempt item attachment ID specified.
  Additional options may be passed to include additional information:

    --mod        Print creation/modification info
EOF

        "assignment" => <<EOF,
sin assignment

  Usage: sin assignment <id> [<options>]

  Prints information about the assignment ID specified. Additional options
  may be passed to include additional information:

    --submissions  Print summary of all submissions
    --xml          Print the raw XML
    --mod          Print creation/modification info
EOF

        "assignment-submission" => <<EOF,
sin assignment-submission

  Usage: sin assignment-submission <id> [<options>]

  Prints information about the assignment submission ID specified. Additional
  options may be passed to include additional information:

    --xml          Print the raw XML
    --mod          Print creation/modification info
EOF

        "forum" => <<EOF,
sin forum

  Usage: sin forum <id> [<options>]

  Prints information about the forum ID specified. Additional options may be
  passed to include additional information:

    --threads    Print summary of all threads
    --mod        Print creation/modification info
EOF

        "forum-thread" => <<EOF,
sin forum-thread

  Usage: sin forum-thread <id> [<options>]

  Prints information about the forum thread ID specified. Additional options
  may be passed to include additional information:

    --posts      Print summary of all posts
    --mod        Print creation/modification info
EOF

        "forum-post" => <<EOF,
sin forum-post

  Usage: sin forum-post <id> [<options>]

  Prints information about the forum post ID specified. Additional options
  may be passed to include additional information:

    --mod        Print creation/modification info
EOF

        "content" => <<EOF,
sin content

  Usage: sin content <id> [<options>]

  Prints information about the content resource or collection ID specified.
  Additional options may be passed to include additional information:

    --properties    Print all properties
    --children      Recursively print collection children
    --full-children Print children with full IDs and file paths
    --mod           Print creation/modification info
EOF
        "deleted-content-resource" => <<EOF,
sin content

  Usage: sin deleted-content-resource <id> [<options>]

  Prints information about the deleted content resource ID specified.
  Additional options may be passed to include additional information:

    --properties    Print all properties
    --mod           Print creation/modification info
EOF
        "announcement" => <<EOF,
sin announcement

  Usage: sin announcement <id> [<options>]

  Prints information about the announcement specified. Additional options may
  be passed to include additional information:

    --xml        Print raw XML content
EOF
        "announcement-channel" => <<EOF,
sin announcement-channel

  Usage: sin announcement-channel <id> [<options>]

  Prints information about the announcement channel specified. Additional
  options may be passed to include additional information:

    --announcements  Print a summary of all announcements in this channel
    --xml            Print raw XML content
EOF
        "gradebook" => <<EOF,
sin gradebook

  Usage: sin gradebook <id> [<options>]

  Prints information about the gradebook ID specified. Additional options may
  be passed to include additional information:

    --items    Print all gradebook items
EOF
        "gradebook-item" => <<EOF,
sin gradebook-item

  Usage: sin gradebook-item <id> [<options>]

  Prints information about the gradebook item ID specified.
EOF
        "role" => <<EOF,
sin role

  Usage: sin role <id> [<options>]

  Prints information about the authz role ID specified.
EOF
        "function" => <<EOF,
sin function

  Usage: sin function <id> [<options>]

  Prints information about the authz function ID specified.
EOF
        "realm" => <<EOF,
sin realm

  Usage: sin realm <id> [<options>]

  Prints information about the authz realm ID specified. Additional options may
  be passed to include additional information:

    --roles      List roles associated with this realm
    --users      List users in this realm
    --mod        Print creation/modification info
EOF
        "private-message" => <<EOF,
sin private-message

  Usage: sin private-message <id> [<options>]

  Prints information about the private message ID specified. Additional options
  may be passed to include additional information:

    --mod        Print creation/modification info
EOF
        "query" => <<EOF,
sin query

  Usage: sin query <object-type> [<options>]

  Query mode is only being tested at present.
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


# query.rb
#   class for handling "query" command line mode
#
# Created 2012-05-23 daveadams@gmail.com
# Last updated 2012-05-23 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  module CLI
    class Query
      def self.process(args, flags)
        # TODO: expand query functionality from proof of concept
        object_type = args.shift
        fields = []
        site_id = nil

        if object_type == "quiz"
          flags.each do |flag|
            case flag
            when /^--fields=/
              fields = flag.split("=")[1].split(",")
            when /^--site=/
              site_id = flag.split("=")[1]
            else
              STDERR.puts "ERROR: Unrecognized query flag"
              exit 1
            end
          end

          if site_id.nil?
            STDERR.puts "ERROR: No site ID was provided"
            exit 1
          end

          puts PublishedQuiz.find_ids_by_site_id(site_id)
        else
          STDERR.puts "ERROR: Unrecognized object type"
          exit 1
        end
      end
    end
  end
end

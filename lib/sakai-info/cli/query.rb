# query.rb
#   class for handling "query" command line mode
#
# Created 2012-05-23 daveadams@gmail.com
# Last updated 2012-10-06 daveadams@gmail.com
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

        elsif object_type == "userid" or object_type == "user_id" or object_type == "uid"
          id = args.shift
          begin
            user = User.find(id)
            puts user.id
          rescue ObjectNotFoundException => e
            STDERR.puts "ERROR: #{e}"
            exit 1
          end

        elsif object_type == "deleted-content"
          userid = nil
          while flags.length > 0
            flag = flags.shift
            if flag =~ /^--by=/
              userid = flag.split('=')[1]
            end
          end

          if userid.nil?
            STDERR.puts "ERROR: you must specify --by=<userid>"
            exit 1
          end

          begin
            user = User.find(userid)
            deleted_resources = DeletedContentResource.find_by_delete_userid(user.id)
            deleted_resources.each do |dr|
              puts dr.id
            end
          rescue ObjectNotFoundException => e
            STDERR.puts "ERROR: #{e}"
            exit 1
          end

        elsif object_type == "site"
          title = args.shift

          Site.find_by_title(title).each do |site|
            puts site.to_csv(:id, :title)
          end

        elsif object_type == "user"
          name = args.shift

          User.find_by_name(name).each do |user|
            puts user.to_csv(:eid, :name)
          end

        else
          STDERR.puts "ERROR: Unrecognized object type"
          exit 1
        end
      end
    end
  end
end

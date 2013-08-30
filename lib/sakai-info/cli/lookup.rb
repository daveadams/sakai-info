# lookup.rb
#   class for handling the default command line mode
#
# Created 2012-05-23 daveadams@gmail.com
# Last updated 2012-10-31 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  module CLI
    class Lookup
      def self.process(args, flags)
        object_type = args.shift
        id = args.shift
        fields = nil
        output = :yaml

        flags_to_delete = []
        flags.each do |flag|
          if flag =~ /^--fields=(.+)$/
            fields = $1.downcase.split(',')
            flags_to_delete << flag
          elsif flag == "--json"
            output = :json
            flags_to_delete << flag
          end
        end

        flags_to_delete.each do |flag|
          flags.delete(flag)
        end

        if flags.include? "--all"
          serials = CLI::LookupModes[object_type].all_serializations
        elsif flags.include? "--dbrow-only"
          serials = [:dbrow_only]
        else
          serials = [:default] + flags.collect{|flag|flag.gsub(/^--/,'').gsub("-","_").to_sym}
        end

        object = nil
        begin
          object = CLI::LookupModes[object_type].find(id)
        rescue ObjectNotFoundException => e
          STDERR.puts "ERROR: #{e}"
          exit 1
        end

        if fields.nil? or fields.empty?
          if output == :json
            puts object.to_json(serials)
          else
            puts object.to_yaml(serials)
          end

        else
          object_hash = object.serialize(serials).delete_if{|k,v| not fields.include? k.to_s}
          if object_hash.empty?
            STDERR.puts "ERROR: no requested fields were found"
            exit 1
          end
          if output == :json
            puts object_hash.to_json
          else
            puts object_hash.to_yaml
          end
        end
      end
    end

    LookupModes = {
      "site" => Site,
      "page" => Page,
      "tool" => Tool,
      "user" => User,
      "group" => Group,
      "pq" => PublishedQuiz,
      "pubquiz" => PublishedQuiz,
      "published-quiz" => PublishedQuiz,
      "nq" => PendingQuiz,
      "penquiz" => PendingQuiz,
      "pending-quiz" => PendingQuiz,
      "pqs" => PublishedQuizSection,
      "pubqs" => PublishedQuizSection,
      "published-quiz-section" => PublishedQuizSection,
      "nqs" => PendingQuizSection,
      "penqs" => PendingQuizSection,
      "pending-quiz-section" => PendingQuizSection,
      "pqi" => PublishedQuizItem,
      "pubqi" => PublishedQuizItem,
      "published-quiz-item" => PublishedQuizItem,
      "nqi" => PendingQuizItem,
      "penqi" => PendingQuizItem,
      "pending-quiz-item" => PendingQuizItem,
      "pqac" => PublishedQuizAccessControl,
      "published-quiz-access-control" => PublishedQuizAccessControl,
      "nqac" => PendingQuizAccessControl,
      "pending-quiz-access-control" => PendingQuizAccessControl,
      "qa" => QuizAttempt,
      "quiz-attempt" => QuizAttempt,
      "qai" => QuizAttemptItem,
      "quiz-attempt-item" => QuizAttemptItem,
      "qaia" => QuizAttemptItemAttachment,
      "quiz-attempt-item-attachment" => QuizAttemptItemAttachment,
      "qp" => QuestionPool,
      "qpool" => QuestionPool,
      "question-pool" => QuestionPool,
      "a" => Assignment,
      "assignment" => Assignment,
      "as" => AssignmentSubmission,
      "asub" => AssignmentSubmission,
      "assignment-submission" => AssignmentSubmission,
      "forum" => Forum,
      "ft" => ForumThread,
      "forum-thread" => ForumThread,
      "fp" => ForumPost,
      "forum-post" => ForumPost,
      "content" => Content,
      "deleted-content-resource" => DeletedContentResource,
      "deleted-content" => DeletedContentResource,
      "delcon" => DeletedContentResource,
      "ann" => Announcement,
      "announcement" => Announcement,
      "annchan" => AnnouncementChannel,
      "announcement-channel" => AnnouncementChannel,
      "gb" => Gradebook,
      "gradebook" => Gradebook,
      "gbi" => GradebookItem,
      "gradebook-item" => GradebookItem,
      "role" => AuthzRole,
      "fn" => AuthzFunction,
      "func" => AuthzFunction,
      "function" => AuthzFunction,
      "realm" => AuthzRealm,
      "private-message" => PrivateMessage,
      "pm" => PrivateMessage,
      "alias" => Alias,
      "metaobj" => Metaobj,
      "form" => Metaobj,
      "wiki-page" => WikiPage,
      "wiki" => WikiPage,
      "wiki-page-history" => WikiPageHistory,
      "wiki-history" => WikiPageHistory,
      "cal" => Calendar,
      "calendar" => Calendar,
      "calendar-event" => CalendarEvent,
      "calevent" => CalendarEvent,
      "ce" => CalendarEvent,
    }
  end
end

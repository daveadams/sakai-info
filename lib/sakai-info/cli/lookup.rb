# lookup.rb
#   class for handling the default command line mode
#
# Created 2012-05-23 daveadams@gmail.com
# Last updated 2012-06-21 daveadams@gmail.com
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

        if flags.include? "--all"
          serials = CLI::LookupModes[object_type].all_serializations
        elsif
          flags.include? "--dbrow-only"
          serials = [:dbrow_only]
        else
          serials = [:default] + flags.collect{|flag|flag.gsub(/^--/,'').gsub("-","_").to_sym}
        end
        begin
          puts CLI::LookupModes[object_type].find(id).to_yaml(serials)
        rescue ObjectNotFoundException
          STDERR.puts "ERROR: Could not find #{object_type} with an ID of '#{id}'"
          exit 1
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
    }
  end
end


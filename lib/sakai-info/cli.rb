# sakai-info/cli.rb
#  - sakai-info command line tool support
#
# Created 2012-02-19 daveadams@gmail.com
# Last updated 2012-05-23 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'sakai-info/cli/help'
require 'sakai-info/cli/lookup'
require 'sakai-info/cli/query'

# it's faster to run single-threaded
Sequel.single_threaded = true

module SakaiInfo
  module CLI
    ObjectModes = {
      "site" => Site,
      "page" => Page,
      "tool" => Tool,
      "user" => User,
      "group" => Group,
      "quiz" => Quiz,
      "quiz-section" => QuizSection,
      "quiz-item" => QuizItem,
      "quiz-attempt" => QuizAttempt,
      "quiz-attempt-item" => QuizAttemptItem,
      "quiz-attempt-item-attachment" => QuizAttemptItemAttachment,
      "qpool" => QuestionPool,
      "question-pool" => QuestionPool,
      "assignment" => Assignment,
      "assignment-submission" => AssignmentSubmission,
      "forum" => Forum,
      "forum-thread" => ForumThread,
      "forum-post" => ForumPost,
      "content" => Content,
      "announcement" => Announcement,
      "announcement-channel" => AnnouncementChannel,
      "gradebook" => Gradebook,
      "gradebook-item" => GradebookItem,
      "role" => AuthzRole,
      "function" => AuthzFunction,
      "realm" => AuthzRealm,
    }
  end
end


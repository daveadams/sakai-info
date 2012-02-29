# sakai-info/cli.rb
#  - sakai-info command line tool support
#
# Created 2012-02-19 daveadams@gmail.com
# Last updated 2012-02-29 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'sakai-info/cli/help'

module SakaiInfo
  class CLI
    ObjectModes = {
      "site" => Site,
      "user" => User,
      "quiz" => Quiz,
      "quiz-section" => QuizSection,
      "quiz-item" => QuizItem,
      "quiz-attempt" => QuizAttempt,
      "quiz-attempt-item" => QuizAttemptItem,
      "quiz-attempt-item-attachment" => QuizAttemptItemAttachment,
      "qpool" => QuestionPool,
      "question-pool" => QuestionPool,
      "assignment" => Assignment,
    }
  end
end


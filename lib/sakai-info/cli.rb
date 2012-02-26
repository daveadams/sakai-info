# sakai-info/cli.rb
#  - sakai-info command line tool support
#
# Created 2012-02-19 daveadams@gmail.com
# Last updated 2012-02-26 daveadams@gmail.com
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
      "qpool" => QuestionPool,
      "question-pool" => QuestionPool,
      "quiz-section" => QuizSection
    }
  end
end


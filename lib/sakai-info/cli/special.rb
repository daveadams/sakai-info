# special.rb
#   class for handling the special command line modes
#
# Created 2012-06-21 daveadams@gmail.com
# Last updated 2012-06-21 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain. See LICENSE.
#

module SakaiInfo
  module CLI
    class Special
      def self.process(args, flags)
        mode = args.shift

        STDERR.puts "WARNING:"
        STDERR.puts "  Looking up items of type '#{mode}' can return ambiguous results."
        STDERR.puts "  Please use #{SpecialModes[mode]} types instead."
        exit 1
      end
    end

    SpecialModes = {
      "quiz" => "'published-quiz' or 'pending-quiz'",
      "quiz-section" => "'published-quiz-section' or 'pending-quiz-section'",
      "quiz-item" => "'published-quiz-item' or 'pending-quiz-item'",
    }
  end
end


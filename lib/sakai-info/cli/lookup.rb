# lookup.rb
#   class for handling the default command line mode
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
    class Lookup
      def self.process(args, flags)
        object_type = args.shift
        id = args.shift

        if flags.include? "--all"
          serials = CLI::ObjectModes[object_type].all_serializations
        elsif
          flags.include? "--dbrow-only"
          serials = [:dbrow_only]
        else
          serials = [:default] + flags.collect{|flag|flag.gsub(/^--/,'').gsub("-","_").to_sym}
        end
        begin
          puts CLI::ObjectModes[object_type].find(id).to_yaml(serials)
        rescue ObjectNotFoundException
          STDERR.puts "ERROR: Could not find #{object_type} with an ID of '#{id}'"
          exit 1
        end
      end
    end
  end
end


# raw_data.rb
#   task definitions for pulling in raw data
#
# Created 2012-05-20 daveadams@gmail.com
# Last updated 2012-05-20 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'net/http'

module Support
  class RawData
    DataDir = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "tmp", "data"))
    FirstNamesFile = File.join(DataDir, "first_names.yml")
    LastNamesFile = File.join(DataDir, "last_names.yml")
  end
end

namespace :data do
  task :create_data_dir do
    print "Creating directory for raw data... "; STDOUT.flush
    system "mkdir -p #{Support::RawData::DataDir}"
    puts "OK"
  end

  desc "Pull raw data to build test database"
  task :pull => [:create_data_dir] do
    print "Fetching first names... "; STDOUT.flush
    first_names = []
    ["http://www.census.gov/genealogy/names/dist.female.first",
     "http://www.census.gov/genealogy/names/dist.male.first"].each do |url|
      content = Net::HTTP.get(URI(url))
      content.each_line do |line|
        first_names << line.split(/ /)[0].downcase.capitalize
      end
    end
    File.open(Support::RawData::FirstNamesFile, "w") do |f|
      f.write(first_names.shuffle.to_yaml)
    end
    puts "OK"

    print "Fetching last names... "; STDOUT.flush
    last_names = []
    ["http://www.census.gov/genealogy/names/dist.all.last"].each do |url|
      content = Net::HTTP.get(URI(url))
      content.each_line do |line|
        last_names << line.split(/ /)[0].downcase.capitalize
      end
    end
    File.open(Support::RawData::LastNamesFile, "w") do |f|
      f.write(last_names.shuffle.to_yaml)
    end
    puts "OK"
  end
end

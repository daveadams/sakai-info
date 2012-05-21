# data.rb
#   task definitions for generating test data
#
# Created 2012-05-21 daveadams@gmail.com
# Last updated 2012-05-21 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'net/http'
require 'base64'

DATADIR = File.join(TMPDIR, 'data')
FIRSTNAMESFILE = File.join(DATADIR, 'first_names.yml')
LASTNAMESFILE = File.join(DATADIR, 'last_names.yml')
FIXTUREDIR = File.join(TMPDIR, 'fixtures')

def create_data_dir
  print "Creating directory for raw data... "; STDOUT.flush
  system "mkdir -p #{DATADIR}"
  puts "OK"
end

def clear_data_dir
  print "Clearing data directory... "; STDOUT.flush
  system "rm -rf #{DATADIR}"
  puts "OK"
end

def create_fixture_dir
  print "Creating directory for fixtures... "; STDOUT.flush
  system "mkdir -p #{FIXTUREDIR}"
  puts "OK"
end

def clear_fixture_dir
  print "Clearing fixture directory... "; STDOUT.flush
  system "rm -rf #{FIXTUREDIR}"
  puts "OK"
end

def fetch_first_names
  if File.exist? FIRSTNAMESFILE
    return
  end
  if not File.exist? DATADIR
    create_data_dir
  end

  print "Fetching first names... "; STDOUT.flush
  first_names = []
  ["http://www.census.gov/genealogy/names/dist.female.first",
   "http://www.census.gov/genealogy/names/dist.male.first"].each do |url|
    content = Net::HTTP.get(URI(url))
    content.each_line do |line|
      first_names << line.split(/ /)[0].downcase.capitalize
    end
  end
  File.open(FIRSTNAMESFILE, "w") do |f|
    f.write(first_names.shuffle.to_yaml)
  end
  puts "OK"
end

def fetch_last_names
  if File.exist? LASTNAMESFILE
    return
  end
  if not File.exist? DATADIR
    create_data_dir
  end

  print "Fetching last names... "; STDOUT.flush
  last_names = []
  ["http://www.census.gov/genealogy/names/dist.all.last"].each do |url|
    content = Net::HTTP.get(URI(url))
    content.each_line do |line|
      last_names << line.split(/ /)[0].downcase.capitalize
    end
  end
  File.open(LASTNAMESFILE, "w") do |f|
    f.write(last_names.shuffle.to_yaml)
  end
  puts "OK"
end

def generate_uuid
  # TODO: replace UUID generation with a ruby solution
  `uuidgen`.chomp
end

PWCHARS =
  ('a'..'z').to_a +
  ('A'..'Z').to_a +
  ('0'..'9').to_a +
  ['~','!','@','#','$','%','^','&','*','-','_','=','+',"'",'"',
   ';',':','.','>',',','<','/','?',"(",")","[","]","{","}",' ']

def generate_password
  (0..(8+rand(9))).map { PWCHARS[rand(PWCHARS.length)] }.join
end

namespace :data do
  desc "Pull raw data to build test database"
  task :pull do
    fetch_first_names
    fetch_last_names
  end

  desc "Generate random fixture data for testing"
  task :generate => [:pull] do
    create_fixture_dir

    sakai_user_id_map =
      [{
         :user_id => "admin",
         :eid => "admin"
       }]
    sakai_user =
      [{
         :user_id => "admin",
         :email => "sakaiadmin@sample.com",
         :first_name => "Sakai",
         :last_name => "Administrator",
         :type => "admin",
         :pw => "VlAvQCY9NC86OSs=",
         :createdby => "admin",
         :createdon => (Time.now - (8*60*60*24*365)),
         :modifiedby => "admin",
         :modifiedon => (Time.now - rand(8*60*60*24*365)),
         :email_lc => "sakaiadmin@sample.com",
       }]
    sakai_user_property = []

    first_names = YAML.load_file(FIRSTNAMESFILE)
    last_names = YAML.load_file(LASTNAMESFILE)

    print "Generating fixtures for 5000 user records... "; STDOUT.flush
    5000.times do
      user_id = generate_uuid
      first_name = first_names[rand(first_names.length)]
      last_name = last_names[rand(last_names.length)]
      eid = (case rand(7)
             when 0 then (first_name[0] + last_name)
             when 1 then (first_name + last_name[0])
             when 2 then (first_name[0] + last_name + (rand(100).to_s))
             when 3 then (first_name + last_name[0] + (rand(100).to_s))
             when 4 then (first_name + (rand(1000).to_s))
             when 5 then (last_name + (rand(1000).to_s))
             when 6 then (first_name[0] + last_name[0] + (rand(10000).to_s))
             end).downcase
      email = eid + "@sample.com"
      type = if rand(100) > 80
               "guest"
             else
               "registered"
             end
      createdby = "admin"
      modifiedby = "admin"
      ago = rand(8*60*60*24*365)
      createdon = (Time.now - ago)
      modifiedon = (Time.now - rand(ago))
      if type == "guest"
        eid = email
        createdby = sakai_user_id_map[rand(sakai_user_id_map.length)][:user_id]
        modifiedby = sakai_user_id_map[rand(sakai_user_id_map.length)][:user_id]
      end
      pw = Base64.encode64(generate_password).chomp

      sakai_user_id_map << {
        :user_id => user_id,
        :eid => eid
      }

      sakai_user << {
        :user_id => user_id,
        :email => email,
        :first_name => first_name,
        :last_name => last_name,
        :type => type,
        :pw => pw,
        :createdby => createdby,
        :createdon => createdon,
        :modifiedby => modifiedby,
        :modifiedon => modifiedon,
        :email_lc => email
      }

      rand(3).times do
        sakai_user_property << {
          :user_id => user_id,
          :name => "prop-#{rand(10000)}-#{rand(10000)}",
          :value => generate_uuid,
        }
      end
    end

    File.open(File.join(FIXTUREDIR, "sakai_user_id_map.yml"), "w") do |f|
      f.write(sakai_user_id_map.to_yaml)
    end

    File.open(File.join(FIXTUREDIR, "sakai_user.yml"), "w") do |f|
      f.write(sakai_user.to_yaml)
    end

    File.open(File.join(FIXTUREDIR, "sakai_user_property.yml"), "w") do |f|
      f.write(sakai_user_property.to_yaml)
    end
    puts "OK"
  end

  desc "Clear raw data and fixture data"
  task :clear do
    clear_fixture_dir
    clear_data_dir
  end
end


# data.rb
#   task definitions for generating test data
#
# Created 2012-05-21 daveadams@gmail.com
# Last updated 2012-10-12 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain. See LICENSE.
#

require 'net/http'
require 'base64'
require 'marky_markov'

DATADIR = File.join(TMPDIR, 'data')
FIRSTNAMESFILE = File.join(DATADIR, 'first_names.yml')
LASTNAMESFILE = File.join(DATADIR, 'last_names.yml')
RAWTEXTFILE = File.join(DATADIR, 'raw.txt')

FIXTUREDIR = File.join(TMPDIR, 'fixtures')
SAKAIUSERIDMAPFILE = File.join(FIXTUREDIR, "sakai_user_id_map.yml")

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
  ["http://www.census.gov/genealogy/www/data/1990surnames/dist.female.first",
   "http://www.census.gov/genealogy/www/data/1990surnames/dist.male.first"].each do |url|
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
  ["http://www.census.gov/genealogy/www/data/1990surnames/dist.all.last"].each do |url|
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

def fetch_raw_text
  if File.exist? RAWTEXTFILE
    return
  end
  if not File.exist? DATADIR
    create_data_dir
  end

  content = ""
  print "Fetching raw text... "; STDOUT.flush
  [
   "http://www.gutenberg.org/cache/epub/1342/pg1342.txt",
   "http://www.gutenberg.org/cache/epub/11/pg11.txt",
   "http://www.gutenberg.org/cache/epub/74/pg74.txt",
   "http://www.gutenberg.org/cache/epub/98/pg98.txt",
  ].each do |url|
    lines = Net::HTTP.get(URI(url)).split("\n")
    content += lines.slice(150,(lines.length-600)).join("\n")
  end
  File.open(RAWTEXTFILE, "w") do |f|
    f.write(content)
  end
  puts "OK"
end

$markov_object = nil
def markov
  if $markov_object.nil?
    if not File.exist? RAWTEXTFILE
      fetch_raw_text
    end

    $markov_object = MarkyMarkov::TemporaryDictionary.new
    $markov_object.parse_file RAWTEXTFILE
  end
  return $markov_object
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

def generate_random_letters
  letters = ('a'..'z').to_a
  (0..(3+rand(9))).map { letters[rand(letters.length)] }.join
end

def generate_random_words(count)
  markov.generate_n_words(count)
end

def generate_random_sentences(count)
  markov.generate_n_sentences(count)
end

def generate_random_paragraphs(count)
  paragraphs = []
  count.times do
    paragraphs << markov.generate_n_sentences(3+rand(5))
  end
  paragraphs.join("\n")
end

def generate_property_name
  case rand(3)
  when 0
    "prop-#{rand(10000)}-#{rand(100000)}"
  when 1
    "setting-#{rand(1000000)}"
  when 2
    generate_random_letters
  end
end

def generate_property_value
  case rand(3)
  when 0
    generate_uuid
  when 1
    generate_password
  when 2
    generate_random_words(3 + rand(3))
  end
end

TOOLS = {
  "osp.glossary" => "Glossary",
  "osp.matrix" => "Matrices",
  "osp.presentation" => "Portfolios",
  "sakai.announcements" => "Announcements",
  "sakai.assignment.grades" => "Assignments",
  "sakai.chat" => "Chat Room",
  "sakai.dropbox" => "Drop Box",
  "sakai.forums" => "Forums",
  "sakai.gradebook.tool" => "Gradebook",
  "sakai.iframe" => "Web Content",
  "sakai.messages" => "Messages",
  "sakai.news" => "News",
  "sakai.podcasts" => "Podcasts",
  "sakai.poll" => "Polls",
  "sakai.postem" => "Post'Em",
  "sakai.profile2" => "Profile",
  "sakai.resources" => "Resources",
  "sakai.rwiki" => "Wiki",
  "sakai.schedule" => "Schedule",
  "sakai.search" => "Search",
  "sakai.sections" => "Section Info",
  "sakai.site.roster" => "Roster",
  "sakai.siteinfo" => "Site Info",
  "sakai.sitestats" => "Site Stats",
  "sakai.syllabus" => "Syllabus",
}

def generate_page_tool_info
  registration = TOOLS.keys[rand(TOOLS.keys.length)]
  page_title = TOOLS[registration]
  tool_title = page_title

  if rand(500) == 499
    page_title = generate_random_words(1+rand(2))
  end

  if rand(5000) == 4999
    tool_title = generate_random_words(1+rand(2))
  end

  popup = 0
  if rand(1300) == 1000
    popup = 1
  end

  layout_hints = nil
  if rand(100) > 55
    layout_hints = "0,0"
  end

  {
    :page_id => generate_uuid,
    :tool_id => generate_uuid,
    :registration => registration,
    :page_title => page_title,
    :tool_title => tool_title,
    :popup => popup,
    :layout_hints => layout_hints,
  }
end

$all_user_ids = nil
def all_user_ids
  if $all_user_ids.nil?
    if not File.exist? SAKAIUSERIDMAPFILE
      STDERR.puts "#{SAKAIUSERIDMAPFILE} does not exist, please regenerate data."
      exit 1
    end
    $all_user_ids = YAML::load_file(SAKAIUSERIDMAPFILE).collect { |v| v[:user_id] }
  end
  $all_user_ids
end

def random_user_id
  all_user_ids[rand(all_user_ids.length)]
end

def generate_users(count)
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

  print "Generating fixtures for #{count} user records... "; STDOUT.flush
  count.times do
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
        :name => generate_property_name,
        :value => generate_property_value,
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

def generate_sites(count)
  sakai_site = []
  sakai_site_property = []
  sakai_site_page = []
  sakai_site_page_property = []
  sakai_site_tool = []
  sakai_site_tool_property = []

  # TODO: generate default sites
  # TODO: generate user workspaces

  print "Generating fixtures for #{count} site records... "; STDOUT.flush
  count.times do
    site_id = generate_uuid
    site_title = generate_random_words(3)
    short_desc = generate_random_sentences(2)
    long_desc = generate_random_paragraphs(1+rand(3))
    published = 1
    if rand(100) > 90
      published = 0
    end

    joinable = 0
    if rand(100) > 95
      joinable = 1
    end

    pubview = 0
    if rand(100) > 80
      pubview = 1
    end

    site_type = "course"
    if rand(100) > 80
      site_type = "project"
      if rand(100) > 95
        site_type = "portfolio"
      end
    end

    join_role = nil
    if joinable == 1
      join_role = "Guest"
      if rand(100) > 50
        join_role = "Participant"
        if site_type == "course"
          join_role = "Student"
        end
      end
    end

    custom_page_ordered = 1
    if rand(100) > 60
      custom_page_ordered = 0
    end

    ago = rand(8*60*60*24*365)
    createdon = (Time.now - ago)
    modifiedon = createdon
    if rand(100) > 40
      modifiedon = (Time.now - rand(ago))
    end

    createdby = random_user_id
    modifiedby = createdby
    if modifiedon != createdon
      if rand(100) > 50
        modifiedby = random_user_id
      end
    end

    sakai_site << {
      :site_id => site_id,
      :title => site_title,
      :type => site_type,
      :short_desc => short_desc,
      :description => long_desc,
      :icon_url => nil,
      :info_url => nil,
      :skin => nil,
      :published => published,
      :joinable => joinable,
      :pubview => pubview,
      :join_role => join_role,
      :createdby => createdby,
      :modifiedby => modifiedby,
      :createdon => createdon,
      :modifiedon => modifiedon,
      :is_special => 0,
      :is_user => 0,
      :custom_page_ordered => custom_page_ordered,
    }

    rand(3).times do
      sakai_site_property << {
        :site_id => site_id,
        :name => generate_property_name,
        :value => generate_property_value,
      }
    end

    site_order = 1
    site_tools = []
    (6+rand(5)).times do
      site_order += 1
      info = nil
      # ensure we don't duplicate any tools
      # TODO: exclude tools that can be duplicated from this rule
      while info.nil?
        info = generate_page_tool_info
        if site_tools.include?(info[:registration])
          info = nil
        end
      end
      site_tools << info[:registration]

      sakai_site_page << {
        :page_id => info[:page_id],
        :site_id => site_id,
        :title => info[:page_title],
        :layout => 0,
        :site_order => site_order,
        :popup => info[:popup],
      }

      rand(3).times do
        sakai_site_page_property << {
          :site_id => site_id,
          :page_id => info[:page_id],
          :name => generate_property_name,
          :value => generate_property_value,
        }
      end

      sakai_site_tool << {
        :tool_id => info[:tool_id],
        :page_id => info[:page_id],
        :site_id => site_id,
        :registration => info[:registration],
        :page_order => 1,
        :title => info[:tool_title],
        :layout_hints => info[:layout_hints],
      }

      rand(3).times do
        sakai_site_tool_property << {
          :site_id => site_id,
          :tool_id => info[:tool_id],
          :name => generate_property_name,
          :value => generate_property_value,
        }
      end
    end
  end

  File.open(File.join(FIXTUREDIR, "sakai_site.yml"), "w") do |f|
    f.write(sakai_site.to_yaml)
  end

  File.open(File.join(FIXTUREDIR, "sakai_site_property.yml"), "w") do |f|
    f.write(sakai_site_property.to_yaml)
  end

  File.open(File.join(FIXTUREDIR, "sakai_site_page.yml"), "w") do |f|
    f.write(sakai_site_page.to_yaml)
  end

  File.open(File.join(FIXTUREDIR, "sakai_site_page_property.yml"), "w") do |f|
    f.write(sakai_site_page_property.to_yaml)
  end

  File.open(File.join(FIXTUREDIR, "sakai_site_tool.yml"), "w") do |f|
    f.write(sakai_site_tool.to_yaml)
  end

  File.open(File.join(FIXTUREDIR, "sakai_site_tool_property.yml"), "w") do |f|
    f.write(sakai_site_tool_property.to_yaml)
  end
  puts "OK"
end

namespace :data do
  desc "Pull raw data to build test database"
  task :pull do
    fetch_first_names
    fetch_last_names
    fetch_raw_text
  end

  desc "Generate random fixture data for testing"
  task :generate => [:pull] do
    if not File.exist? FIXTUREDIR
      create_fixture_dir
    end

    if (not (File.exist?(File.join(FIXTUREDIR, "sakai_user_id_map.yml")) and
             File.exist?(File.join(FIXTUREDIR, "sakai_user.yml")) and
             File.exist?(File.join(FIXTUREDIR, "sakai_user_property.yml"))))
      generate_users(50)
    end

    if (not (File.exist?(File.join(FIXTUREDIR, "sakai_site.yml")) and
             File.exist?(File.join(FIXTUREDIR, "sakai_site_property.yml")) and
             File.exist?(File.join(FIXTUREDIR, "sakai_site_page.yml")) and
             File.exist?(File.join(FIXTUREDIR, "sakai_site_page_property.yml")) and
             File.exist?(File.join(FIXTUREDIR, "sakai_site_tool.yml")) and
             File.exist?(File.join(FIXTUREDIR, "sakai_site_tool_property.yml"))))
      generate_sites(10)
    end
  end

  desc "Clear raw data and fixture data"
  task :clear do
    clear_fixture_dir
    clear_data_dir
  end
end


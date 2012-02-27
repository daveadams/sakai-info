# Rakefile
#   rake definitions
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-25 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'lib/sakai-info/version'

GEM_NAME = "sakai-info"
GEM_FULLNAME = "#{GEM_NAME}-#{SakaiInfo::VERSION}"
GEM_FILENAME = "#{GEM_FULLNAME}.gem"

namespace :gem do
  desc "Build the gem file sakai-info-#{GEM_FILENAME}"
  task :build => :test do
    system "gem build sakai-info.gemspec"
  end

  desc "Install #{GEM_FILENAME} in your local rubygems library"
  task :install => :build do
    system "sudo gem install #{GEM_FILENAME} --no-rdoc --no-ri"
  end

  desc "Remove #{GEM_NAME} gem from your local rubygems library"
  task :uninstall do
    system "sudo gem uninstall #{GEM_NAME}"
  end

  desc "Upload built gem to RubyForge"
  task :release => :build do
    system "gem push #{GEM_FILENAME}"
  end
end

desc "Find and print all TODO annotations"
task :todo do
  system "for FILE in $(grep -rl TODO: * --exclude=Rakefile); do echo $FILE; cat -n $FILE |grep TODO: |sed 's/^ *\\([0-9]\\+\\).*TODO:/  \\1- TODO:/' ; echo; done |sed '$d'"
end

desc "Delete built gemfiles"
task :clean do
  system "rm sakai-info-*.gem"
end

SchemaDir = 'tmp/schema'
namespace :schema do
  desc "Dump schema creation files to #{SchemaDir}"
  task :dump, :connstr do |t, args|
    puts args.inspect

    if not Dir.exist? 'tmp'
      Dir.mkdir 'tmp'
    end

    if not Dir.exist? SchemaDir
      Dir.mkdir SchemaDir
    end

    require 'sequel'
    Sequel.extension(:schema_dumper)
    db = Sequel.connect(args[:connstr])

    UserTables = [:sakai_user, :sakai_user_property, :sakai_user_id_map, :sakai_preferences]
    SiteTables = [:sakai_site, :sakai_site_property, :sakai_site_user,
                  :sakai_site_page, :sakai_site_page_property,
                  :sakai_site_tool, :sakai_site_tool_property]
    GroupTables = [:sakai_site_group, :sakai_site_group_property]
    AuthzTables = [:sakai_realm_rl_gr, :sakai_realm_rl_fn, :sakai_realm,
                   :sakai_realm_role, :sakai_realm_role_desc, :sakai_realm_function,
                   :sakai_realm_provider, :sakai_realm_property]
    AssignmentTables = [:assignment_assignment, :assignment_submission, :assignment_content]
    ExtraAssignmentTables = [:asn_ap_item_access_t, :asn_ap_item_t, :asn_ma_item_t,
                             :asn_note_item_t, :asn_sup_attach_t, :asn_sup_item_t]
    AnnouncementTables = [:announcement_channel, :announcement_message]
    ContentTables = [:content_resource, :content_resource_delete, :content_resource_lock,
                     :content_collection, :content_type_registry, :content_dropbox_changes]
    GradebookTables = [:gb_gradebook_t, :gb_gradable_object_t]
    ExtraGradebookTables = [:gb_action_record_t, :gb_action_record_property_t,
                            :gb_category_t, :gb_comment_t, :gb_grade_map_t,
                            :gb_grade_record_t, :gb_grade_to_percent_mapping_t,
                            :gb_grading_event_t, :gb_grading_scale_grades_t,
                            :gb_grading_scale_percents_t, :gb_grading_scale_t,
                            :gb_lettergrade_mapping, :gb_lettergrade_percent_mapping,
                            :gb_permission_t, :gb_property_t, :gb_spreadsheet_t,
                            :gb_user_config_t, :gb_user_dereference_t,
                            :gb_user_deref_rm_update_t]
    MessageTables = [:mfr_message_t, :mfr_open_forum_t, :mfr_area_t]
    ExtraMessageTables = [:mfr_actor_permissions_t, :mfr_ap_accessors_t,
                          :mfr_ap_contributors_t, :mfr_ap_moderators_t,
                          :mfr_attachment_t, :mfr_control_permissions_t,
                          :mfr_date_restrictions_t, :mfr_email_notification_t,
                          :mfr_label_t, :mfr_membership_item_t,
                          :mfr_message_forums_user_t, :mfr_message_permissions_t,
                          :mfr_permission_level_t, :mfr_private_forum_t,
                          :mfr_pvt_msg_usr_t, :mfr_synoptic_item,
                          :mfr_topic_t, :mfr_unread_status_t]
    QuestionPoolTables = [:sam_questionpool_t, :sam_questionpoolitem_t]
    ExtraQuestionPoolTables = [:sam_questionpoolaccess_t]
    QuizTables = [:sam_authzdata_t, :sam_assessmentbase_t, :sam_publishedassessment_t,
                  :sam_section_t, :sam_publishedsection_t, :sam_item_t, :sam_publisheditem_t]
    ExtraQuizTables = [:sam_answer_t, :sam_answerfeedback_t, :sam_assessaccesscontrol_t,
                       :sam_assessevaluation_t, :sam_assessfeedback_t, :sam_assessmentgrading_t,
                       :sam_assessmetadata_t, :sam_attachment_t, :sam_functiondata_t,
                       :sam_gradingattachment_t, :sam_gradingsummary_t, :sam_itemfeedback_t,
                       :sam_itemgrading_t, :sam_itemmetadata_t, :sam_itemtext_t, :sam_media_t,
                       :sam_publishedaccesscontrol_t, :sam_publishedanswerfeedback_t,
                       :sam_publishedanswer_t, :sam_publishedassessment_t,
                       :sam_publishedevaluation_t, :sam_publishedfeedback_t,
                       :sam_publisheditemfeedback_t, :sam_publisheditemmetadata_t,
                       :sam_publisheditemtext_t, :sam_publishedmetadata_t,
                       :sam_publishedsectionmetadata_t, :sam_publishedsecureip_t,
                       :sam_qualifierdata_t, :sam_sectionmetadata_t, :sam_securedip_t,
                       :sam_studentgradingsummary_t, :sam_type_t]

    [UserTables, SiteTables, GroupTables, AuthzTables, AssignmentTables,
     AnnouncementTables, GradebookTables, MessageTables, QuestionPoolTables,
     QuizTables].flatten.each do |table|
      print "Dumping table #{table}... ";STDOUT.flush
      File.open(File.join(SchemaDir, "create_#{table}.rb"), "w") do |f|
        f.write(db.dump_table_schema(table))
      end
      puts "OK"
    end
  end
end

# standard unit tests
require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << 'test'
end

# make the default task to run tests
desc "By default, rake will run tests"
task :default => :test


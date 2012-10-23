# schema.rb
#   rake task support
#
# Created 2012-05-21 daveadams@gmail.com
# Last updated 2012-10-23 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

SCHEMADUMPDIR = File.join(TMPDIR, 'schema')

Tables = {
  :user => [:sakai_user, :sakai_user_property, :sakai_user_id_map, :sakai_preferences],
  :site => [:sakai_site, :sakai_site_property, :sakai_site_user,
            :sakai_site_page, :sakai_site_page_property,
            :sakai_site_tool, :sakai_site_tool_property],
  :group => [:sakai_site_group, :sakai_site_group_property],
  :authz => [:sakai_realm_rl_gr, :sakai_realm_rl_fn, :sakai_realm,
             :sakai_realm_role, :sakai_realm_function],
  :assignment => [:assignment_assignment, :assignment_submission, :assignment_content],
  :announcement => [:announcement_channel, :announcement_message],
  :content => [:content_resource, :content_collection, :content_resource_delete],
  :gradebook => [:gb_gradebook_t, :gb_gradable_object_t],
  :message => [:mfr_message_t, :mfr_open_forum_t, :mfr_area_t, :mfr_topic_t],
  :question_pool => [:sam_questionpool_t, :sam_questionpoolitem_t],
  :quiz => [:sam_authzdata_t, :sam_assessmentbase_t, :sam_publishedassessment_t,
            :sam_section_t, :sam_publishedsection_t, :sam_item_t, :sam_publisheditem_t,
            :sam_assessmentgrading_t, :sam_itemgrading_t, :sam_media_t,
            :sam_assessaccesscontrol_t, :sam_publishedaccesscontrol_t],
  :alias => [:sakai_alias, :sakai_alias_property],
  :metaobj => [:metaobj_form_def],
  :wiki => [:rwikiobject, :rwikicurrentcontent, :rwikihistory, :rwikihistorycontent,
            :rwikipreference, :rwikipagepresence],
}

ExtraTables = {
  :authz => [:sakai_realm_role_desc, :sakai_realm_provider, :sakai_realm_property],
  :assignment => [:asn_ap_item_access_t, :asn_ap_item_t, :asn_ma_item_t,
                  :asn_note_item_t, :asn_sup_attach_t, :asn_sup_item_t],
  :content => [:content_resource_lock, :content_type_registry, :content_dropbox_changes],
  :gradebook => [:gb_action_record_t, :gb_action_record_property_t, :gb_category_t,
                 :gb_comment_t, :gb_grade_map_t, :gb_grade_record_t, :gb_property_t,
                 :gb_grade_to_percent_mapping_t, :gb_grading_event_t,
                 :gb_grading_scale_grades_t, :gb_grading_scale_percents_t,
                 :gb_grading_scale_t, :gb_lettergrade_mapping, :gb_spreadsheet_t,
                 :gb_lettergrade_percent_mapping, :gb_permission_t, :gb_user_config_t,
                 :gb_user_dereference_t, :gb_user_deref_rm_update_t],
  :message => [:mfr_actor_permissions_t, :mfr_ap_accessors_t,
               :mfr_ap_contributors_t, :mfr_ap_moderators_t,
               :mfr_attachment_t, :mfr_control_permissions_t,
               :mfr_date_restrictions_t, :mfr_email_notification_t,
               :mfr_label_t, :mfr_membership_item_t,
               :mfr_message_forums_user_t, :mfr_message_permissions_t,
               :mfr_permission_level_t, :mfr_private_forum_t,
               :mfr_pvt_msg_usr_t, :mfr_synoptic_item, :mfr_unread_status_t],
  :question_pool => [:sam_questionpoolaccess_t],
  :quiz => [:sam_answer_t, :sam_answerfeedback_t,
            :sam_assessevaluation_t, :sam_assessfeedback_t,
            :sam_assessmetadata_t, :sam_attachment_t, :sam_functiondata_t,
            :sam_gradingattachment_t, :sam_gradingsummary_t, :sam_itemfeedback_t,
            :sam_itemmetadata_t, :sam_itemtext_t,
            :sam_publishedanswerfeedback_t,
            :sam_publishedanswer_t, :sam_publishedassessment_t,
            :sam_publishedevaluation_t, :sam_publishedfeedback_t,
            :sam_publisheditemfeedback_t, :sam_publisheditemmetadata_t,
            :sam_publisheditemtext_t, :sam_publishedmetadata_t,
            :sam_publishedsectionmetadata_t, :sam_publishedsecureip_t,
            :sam_qualifierdata_t, :sam_sectionmetadata_t, :sam_securedip_t,
            :sam_studentgradingsummary_t, :sam_type_t]
}

# return a list of the tables we care about right now
def table_list
  Tables.values.flatten
end

# return a list of the extra tables we know about but don't care about yet
def extra_table_list
  ExtraTables.values.flatten
end

def db_connect(connection_name = :default)
  SakaiInfo::DB.connect(connection_name)
end

namespace :schema do
  desc "List database tables used in the code"
  task :tables do
    # TODO: find a non-linux way to make this list
    system "grep -hroE 'DB.connect\[:[a-z_]+\]' lib/sakai-info " +
      "|cut -d: -f2 |cut -d']' -f1 |grep -vF 'DB.connect[' |sort -u"
  end

  desc "Dump schema creation files"
  task :dump, [:db] do |t, args|
    args.with_defaults(:db => :default)

    db = db_connect(args[:db])
    Sequel.extension(:schema_dumper)

    if not File.exist? SCHEMADUMPDIR
      print "Creating directory for schema creation files... "; STDOUT.flush
      system "mkdir -p #{SCHEMADUMPDIR}"
      puts "OK"
    end

    print "Deleting any old schema creation files... ";STDOUT.flush
    n = File.delete(*Dir[File.join(SCHEMADUMPDIR, "create_*.rb")])
    puts "#{n} files deleted"

    puts "Dumping schema creation files to disk:"
    table_list.each do |table|
      print "  Dumping table #{table}... ";STDOUT.flush
      File.open(File.join(SCHEMADUMPDIR, "create_#{table}.rb"), "w") do |f|
        f.write(db.dump_table_schema(table).each_line.collect do |line|
                  line.chomp!
                  if line =~ /^  primary_key / and line =~ /:type=>(String|BigDecimal)/
                    line + ", :auto_increment=>false"
                  else
                    line
                  end
                end.join("\n"))
      end
      puts "OK"
    end
  end
end


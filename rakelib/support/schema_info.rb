# schema_info.rb
#   Support::SchemaInfo class for rake task support
#
# Created 2012-02-27 daveadams@gmail.com
# Last updated 2012-05-20 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module Support
  class SchemaInfo
    DumpDir = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "tmp", "schema"))
    TestDbDir = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "tmp", "db"))
    TestDbFile = File.join(TestDbDir, "test.db")

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
      :content => [:content_resource, :content_collection],
      :gradebook => [:gb_gradebook_t, :gb_gradable_object_t],
      :message => [:mfr_message_t, :mfr_open_forum_t, :mfr_area_t],
      :question_pool => [:sam_questionpool_t, :sam_questionpoolitem_t],
      :quiz => [:sam_authzdata_t, :sam_assessmentbase_t, :sam_publishedassessment_t,
                :sam_section_t, :sam_publishedsection_t, :sam_item_t, :sam_publisheditem_t,
                :sam_assessmentgrading_t, :sam_itemgrading_t, :sam_media_t]
    }

    ExtraTables = {
      :authz => [:sakai_realm_role_desc, :sakai_realm_provider, :sakai_realm_property],
      :assignment => [:asn_ap_item_access_t, :asn_ap_item_t, :asn_ma_item_t,
                      :asn_note_item_t, :asn_sup_attach_t, :asn_sup_item_t],
      :content => [:content_resource_delete, :content_resource_lock, :content_type_registry,
                   :content_dropbox_changes],
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
                   :mfr_pvt_msg_usr_t, :mfr_synoptic_item,
                   :mfr_topic_t, :mfr_unread_status_t],
      :question_pool => [:sam_questionpoolaccess_t],
      :quiz => [:sam_answer_t, :sam_answerfeedback_t, :sam_assessaccesscontrol_t,
                :sam_assessevaluation_t, :sam_assessfeedback_t,
                :sam_assessmetadata_t, :sam_attachment_t, :sam_functiondata_t,
                :sam_gradingattachment_t, :sam_gradingsummary_t, :sam_itemfeedback_t,
                :sam_itemmetadata_t, :sam_itemtext_t,
                :sam_publishedaccesscontrol_t, :sam_publishedanswerfeedback_t,
                :sam_publishedanswer_t, :sam_publishedassessment_t,
                :sam_publishedevaluation_t, :sam_publishedfeedback_t,
                :sam_publisheditemfeedback_t, :sam_publisheditemmetadata_t,
                :sam_publisheditemtext_t, :sam_publishedmetadata_t,
                :sam_publishedsectionmetadata_t, :sam_publishedsecureip_t,
                :sam_qualifierdata_t, :sam_sectionmetadata_t, :sam_securedip_t,
                :sam_studentgradingsummary_t, :sam_type_t]
    }

    # return a list of the tables we care about right now
    def self.tables
      Tables.values.flatten
    end

    # return a list of the extra tables we know about but don't care about yet
    def self.extra_tables
      ExtraTables.values.flatten
    end
  end
end


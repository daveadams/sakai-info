# test_site.rb
#   Tests for SakaiInfo::Site
#
# Created 2012-10-13 daveadams@gmail.com
# Last updated 2012-10-13 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require_relative 'testlib/helper'

class SiteTest < MiniTest::Unit::TestCase
  def fetch_random_site_id
    site_count = @@db[:sakai_site].count
    assert(site_count > 0, "No sites in SAKAI_SITE table")

    i = rand(site_count)
    assert((i >= 0 and i < site_count), "i (#{i}) is out of bounds (0 <= i < #{site_count})")

    site_id = @@db[:sakai_site].select(:site_id).all[i][:site_id]
    assert((not site_id.nil?), "Site ID is nil!")

    site_id
  end

  def fetch_random_site
    Site.find(fetch_random_site_id)
  end

  # this is run before each test
  def setup
    skip if not Helper.test_database_available?
    @@db = DB.connect
    SakaiInfo::Cache.clear_all
  end

  # test that sites exists in the database
  def test_sites_exist
    assert(@@db[:sakai_site].count > 0)
    assert(@@db[:sakai_site_page].count > 0)
    assert(@@db[:sakai_site_tool].count > 0)
  end

  # test that object construction works
  def test_construction
    # test with 10 random sites
    10.times do
      site = fetch_random_site

      row = @@db[:sakai_site].where(:site_id => site.id).first
      assert((not row.nil?), "Row is nil!")

      s = Site.new(row)
      assert((not s.nil?), "s is nil!")

      # test the interface
      assert_respond_to(s, :id)
      assert_respond_to(s, :dbrow)
      assert_respond_to(s, :title)
      assert_respond_to(s, :properties)
      assert_respond_to(s, :membership)
      assert_respond_to(s, :user_count)
      assert_respond_to(s, :assignments)
      assert_respond_to(s, :serialize)
      assert_respond_to(s, :to_yaml)
      assert_respond_to(s, :to_json)

      # test the attributes
      assert_equal(row[:site_id], s.id)
      assert_equal(row[:title], s.title)
      assert_equal(row[:type], s.type)

      # test more involved attributes
      assert_equal(s.user_count, s.membership.count,
                   "User count and membership count do not match!")

      # test dbrow
      assert_equal(row, s.dbrow)
    end
  end

  # test CLI automation interface
  def test_cli_automation_interface
    s = fetch_random_site

    assert_respond_to(Site, :all_serializations)
    Site.all_serializations.each do |serial|
      method_name = "#{serial.to_s}_serialization".to_sym
      assert_respond_to(s, method_name)
    end
  end

  # test serializations
  def test_summary_serialization
    10.times do
      s = fetch_random_site
      expected_summary_serialization = {
        "id" => s.id,
        "title" => s.title,
        "type" => s.type,
        "created_by" => s.created_by.eid,
      }
      assert_equal(expected_summary_serialization, s.serialize(:summary))
    end
  end

  # test lookup functionality
  def test_lookup
    10.times do
      site_id = fetch_random_site_id
      SakaiInfo::Cache.clear_all

      s1 = Site.find(site_id)
      assert((not s1.nil?), "Site could not be found the first time")
      SakaiInfo::Cache.clear_all

      s2 = Site.find(site_id)
      assert((not s2.nil?), "Site could not be found the second time")
      SakaiInfo::Cache.clear_all

      assert_equal(s1.dbrow, s2.dbrow)
      assert_equal(s1.id, s2.id)
      assert_equal(s1.title, s2.title)
      assert_equal(s1.user_count, s2.user_count)
      assert_equal(s1.serialize(:summary), s2.serialize(:summary))
      assert_equal(s1.serialize(:summary).to_yaml, s2.serialize(:summary).to_yaml)
      assert_equal(s1.serialize(:summary).to_json, s2.serialize(:summary).to_json)
    end
  end
end


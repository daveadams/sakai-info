# test_user.rb
#   Tests for SakaiInfo::User
#
# Created 2012-02-18 daveadams@gmail.com
# Last updated 2012-10-12 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require_relative 'testlib/helper'

class UserTest < MiniTest::Unit::TestCase
  def fetch_random_user_id
    user_count = @@db[:sakai_user].count
    assert(user_count > 0, "No users in SAKAI_USER table")

    i = rand(user_count)
    assert((i >= 0 and i < user_count), "i (#{i}) is out of bounds (0 <= i < #{user_count})")

    user_id = @@db[:sakai_user].select(:user_id).all[i][:user_id]
    assert((not user_id.nil?), "User ID is nil!")

    user_id
  end

  def fetch_random_user
    User.find(fetch_random_user_id)
  end

  # this is run before each test
  def setup
    skip if not Helper.test_database_available?
    @@db = DB.connect
    SakaiInfo::Cache.clear_all
  end

  # test that users exists in the database
  def test_users_exist
    assert(@@db[:sakai_user].count > 0)
    assert(@@db[:sakai_user_id_map].count > 0)
  end

  # test that object construction works
  def test_construction
    # test with 10 random users
    10.times do
      user = fetch_random_user

      row = @@db[:sakai_user].where(:user_id => user.id).first
      assert((not row.nil?), "Row is nil!")

      u = User.new(row)
      assert((not u.nil?), "u is nil!")

      eid = User.get_eid(u.id)
      assert((not eid.nil?), "EID is nil!")

      # test the interface
      assert_respond_to(u, :id)
      assert_respond_to(u, :dbrow)
      assert_respond_to(u, :name)
      assert_respond_to(u, :properties)
      assert_respond_to(u, :membership)
      assert_respond_to(u, :site_count)
      assert_respond_to(u, :question_pools)
      assert_respond_to(u, :serialize)
      assert_respond_to(u, :to_yaml)
      assert_respond_to(u, :to_json)

      # test the attributes
      assert_equal(row[:user_id], u.id)
      assert_equal("#{row[:first_name]} #{row[:last_name]}", u.name)
      assert_equal(row[:type], u.type)
      assert_equal(eid, u.eid)

      # test more involved attributes
      assert_equal(u.site_count, u.membership.count,
                   "Site count and membership count do not match!")

      # test dbrow
      assert_equal(row, u.dbrow)
    end
  end

  # test CLI automation interface
  def test_cli_automation_interface
    u = fetch_random_user

    assert_respond_to(User, :all_serializations)
    User.all_serializations.each do |s|
      method_name = "#{s.to_s}_serialization".to_sym
      assert_respond_to(u, method_name)
    end
  end

  # test serializations
  def test_summary_serialization
    10.times do
      u = fetch_random_user
      expected_summary_serialization = {
        "id" => u.id,
        "eid" => u.eid,
        "name" => u.name,
        "type" => u.type,
      }
      assert_equal(expected_summary_serialization, u.serialize(:summary))
    end
  end

  # test lookup functionality
  def test_lookup_by_user_id_and_eid
    10.times do
      user_id = fetch_random_user_id
      eid = User.get_eid(user_id)
      SakaiInfo::Cache.clear_all

      u1 = User.find(user_id)
      assert((not u1.nil?), "User could not be found by user_id")
      SakaiInfo::Cache.clear_all

      u2 = User.find(eid)
      assert((not u2.nil?), "User could not be found by EID")
      SakaiInfo::Cache.clear_all

      assert_equal(u1.dbrow, u2.dbrow)
      assert_equal(u1.id, u2.id)
      assert_equal(u1.eid, u2.eid)
      assert_equal(u1.site_count, u2.site_count)
      assert_equal(u1.serialize(:summary), u2.serialize(:summary))
      assert_equal(u1.serialize(:summary).to_yaml, u2.serialize(:summary).to_yaml)
      assert_equal(u1.serialize(:summary).to_json, u2.serialize(:summary).to_json)
    end
  end
end


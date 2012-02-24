# test_user.rb
#   Tests for SakaiInfo::User
#
# Created 2012-02-18 daveadams@gmail.com
# Last updated 2012-02-18 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'test/unit'
require 'sakai-info'

class UserTest < Test::Unit::TestCase
  Data = {
    "id" => "id1",
    "eid" => "eid1",
    "name" => "User One",
    "type" => "test",
    "created_at" => (Time.now - (60*60*24*5)).strftime("%Y-%m-%d %H:%M:%S"),
    "modified_at" => (Time.now - (60*60*24*5)).strftime("%Y-%m-%d %H:%M:%S")
  }

  def fetch_user_object
    SakaiInfo::User.new(Data["id"], Data["eid"], Data["name"], Data["type"],
                        Data["created_at"], Data["modified_at"])
  end

  # test that object construction works
  def test_construction
    u = nil
    assert_nothing_raised do
      u = fetch_user_object
    end
    assert_not_nil(u)

    # test the interface
    assert_respond_to(u, :id)
    assert_respond_to(u, :serialize)
    assert_respond_to(u, :default_serialization)
    assert_respond_to(u, :object_type_serialization)
    assert_respond_to(u, :summary_serialization)
    assert_respond_to(u, :sites_serialization)
    assert_respond_to(u, :pools_serialization)
    assert_respond_to(u, :to_yaml)
    assert_respond_to(u, :to_json)

    # test that all the attr_readers work
    assert_equal(u.id, Data["id"])
    assert_equal(u.eid, Data["eid"])
    assert_equal(u.name, Data["name"])
    assert_equal(u.type, Data["type"])
    assert_equal(u.created_at, Data["created_at"])
    assert_equal(u.modified_at, Data["modified_at"])
  end

  # test CLI automation interface
  def test_cli_automation_interface
    assert_respond_to(SakaiInfo::User, :all_serializations)
    u = fetch_user_object
    SakaiInfo::User.all_serializations.each do |s|
      method_name = "#{s.to_s}_serialization".to_sym
      assert_respond_to(u, method_name)
    end
  end

  # test serializations
  def test_serialization
    u = fetch_user_object
    assert_equal({"sakai_object_type" => SakaiInfo::User}, u.serialize(:object_type))
    # TODO: add real serialization tests for User
  end

  # TODO: add lookup tests for User
end


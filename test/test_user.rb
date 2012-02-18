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
  # test that object construction works
  def test_construction
    data = {
      "id" => "id1",
      "eid" => "eid1",
      "name" => "User One",
      "type" => "test",
      "created_at" => (Time.now - (60*60*24*5)).strftime("%Y-%m-%d %H:%M:%S"),
      "modified_at" => (Time.now - (60*60*24*5)).strftime("%Y-%m-%d %H:%M:%S")
    }

    u = nil
    assert_nothing_raised do
      u = SakaiInfo::User.new(data["id"], data["eid"], data["name"], data["type"],
                              data["created_at"], data["modified_at"])
    end
    assert_not_nil(u)

    assert_equal(u.id, data["id"])
    assert_equal(u.eid, data["eid"])
    assert_equal(u.name, data["name"])
    assert_equal(u.type, data["type"])
    assert_equal(u.created_at, data["created_at"])
    assert_equal(u.modified_at, data["modified_at"])
  end
end


# test_sakai_object.rb
#   Tests for SakaiInfo::SakaiObject
#
# Created 2012-02-16 daveadams@gmail.com
# Last updated 2012-10-12 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'test/unit'
require 'sakai-info'

module SakaiInfo
  class TestSakaiObjectSubclass < SakaiObject
    attr_reader :dbrow, :value

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:id]
      @int = dbrow[:int]
      @value = dbrow[:value]
    end

    def int
      @int + 10
    end

    def default_serialization
      {
        "id" => self.id,
        "int" => self.int,
      }
    end

    def summary_serialization
      {
        "id" => self.id,
      }
    end

    def value_serialization
      {
        "value" => self.value,
      }
    end

    def all_serializations
      [
       :default,
       :value,
      ]
    end
  end
end

class SakaiObjectTest < Test::Unit::TestCase
  # test basic object construction
  def test_object
    so = SakaiInfo::SakaiObject.new

    assert_respond_to(so, :id)
    assert_respond_to(so, :default_serialization)
    assert_respond_to(so, :object_type_serialization)
    assert_respond_to(so, :serialize)
    assert_respond_to(so, :to_yaml)
    assert_respond_to(so, :to_json)
  end

  # test basic serialization methods
  def test_serialization
    so = SakaiInfo::SakaiObject.new

    # specifying non-existent serializations should raise no NameErrors
    assert_nothing_raised do
      # many ways of asking for the same thing
      # the default and object_type serializations should include the object classname
      # shell and summary serializations default to the default serialization
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.default_serialization)
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.serialize)
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.serialize(:default))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.serialize("default"))

      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.object_type_serialization)
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.serialize(:object_type))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.serialize("object_type"))

      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.summary_serialization)
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.serialize(:summary))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.serialize("summary"))

      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.shell_serialization)
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.serialize(:shell))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.serialize("shell"))

      # requesting any other serializations without :default should result in empty hashes
      # since no other serializations are defined at the base level
      assert_equal({}, so.serialize(:xyz))
      assert_equal({}, so.serialize(:Default))
      assert_equal({}, so.serialize("maybe", "bakery"))
      assert_equal({}, so.serialize(:non_existent_serialization, :and_another, :onemore))

      # combining :default with anything else should bring us back to just
      # the result for :default
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize(:default, :xyz))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize(:xyz, :default))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize("default", "xyz"))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize(:one, :two, :three, :default, :eight, :four, :two))

      # asking for :default (or equivalent) multiple times should produce only one
      # copy of the data
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize(:default, :default))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize(:default, :xyz, :default))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize(:xyz, :default, :xyz, :default, :xyz, :summary, :xyz))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize(:default, :one, :shell, :two, :default,
                                :three, :summary, :four, :default))
    end
  end

  def test_subclass
    row = { :id => "abcd-efgh", :int => 5, :value => "veritas" }

    obj = SakaiInfo::TestSakaiObjectSubclass.new(row)

    # verify the object was constructed correctly
    assert_equal(obj.id, row[:id])
    assert_equal(obj.value, row[:value])
    assert_equal(obj.int, (row[:int] + 10))

    # verify expected serializations
    expected_default_serialization = { "id" => row[:id], "int" => (row[:int] + 10) }
    expected_summary_serialization = { "id" => row[:id] }
    expected_value_serialization = { "value" => row[:value] }
    expected_all_serialization =
      { "id" => row[:id], "int" => (row[:int] + 10), "value" => row[:value] }
    expected_dbrow_serialization =
      { "id" => row[:id], "int" => (row[:int] + 10), "dbrow" => row }
    expected_dbrow_only_serialization = row

    assert_equal(obj.default_serialization, expected_default_serialization)
    assert_equal(obj.summary_serialization, expected_summary_serialization)
    assert_equal(obj.value_serialization, expected_value_serialization)

    assert_equal(obj.serialize, expected_default_serialization)
    assert_equal(obj.serialize(:summary), expected_summary_serialization)
    assert_equal(obj.serialize(:value), expected_value_serialization)
    assert_equal(obj.serialize(obj.all_serializations), expected_all_serialization)

    assert_equal(obj.serialize(:default, :dbrow), expected_dbrow_serialization)
    assert_equal(obj.serialize(:dbrow_only), expected_dbrow_only_serialization)
  end

  # TODO: test yaml and json output
  def test_serialization_strings
  end
end


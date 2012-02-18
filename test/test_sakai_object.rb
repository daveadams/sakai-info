# test_sakai_object.rb
#   Tests for SakaiInfo::SakaiObject
#
# Created 2012-02-16 daveadams@gmail.com
# Last updated 2012-02-16 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'test/unit'
require 'sakai-info'

module SakaiInfo
  class TestSakaiObjectSubclass < SakaiObject
  end
end

class SakaiObjectTest < Test::Unit::TestCase
  # test basic object construction
  def test_object
    so = SakaiInfo::SakaiObject.new

    assert_respond_to(so, :id)
    assert_respond_to(so, :default_serialization)
    assert_respond_to(so, :object_type_serialization)
  end

  # test basic serialization methods
  def test_serialization
    so = SakaiInfo::SakaiObject.new

    # specifying non-existent serializations should raise no NameErrors
    assert_nothing_raised do
      # many ways of asking for the same thing
      # the default and object_type serializations should include the object classname
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.default_serialization)
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.serialize)
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.serialize(:default))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.serialize("default"))

      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.object_type_serialization)
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.serialize(:object_type))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject}, so.serialize("object_type"))

      # requesting any other serializations without :default should result in empty hashes
      # since no other serializations are defined at the base level
      assert_equal({}, so.serialize(:summary))
      assert_equal({}, so.serialize(:Default))
      assert_equal({}, so.serialize("summary", "bakery"))
      assert_equal({}, so.serialize(:non_existent_serialization, :and_another, :onemore))

      # combining :default with anything else should bring us back to just
      # the result for :default
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize(:default, :summary))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize(:summary, :default))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize("default", "summary"))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize(:one, :two, :three, :default, :eight, :four, :two))

      # asking for :default multiple times should produce only one copy of the data
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize(:default, :default))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize(:default, :summary, :default))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize(:summary, :default, :summary, :default, :summary))
      assert_equal({"sakai_object_type" => SakaiInfo::SakaiObject},
                   so.serialize(:default, :one, :default, :two, :default,
                                :three, :default, :four, :default))
    end
  end

  # TODO: test an extension class with multiple serializations
  def test_subclass
  end

  # TODO: test yaml and json output
  def test_serialization_strings
  end
end


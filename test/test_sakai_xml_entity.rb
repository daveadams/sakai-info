# test_sakai_xml_entity.rb
#   Tests for SakaiInfo::SakaiXMLEntity
#
# Created 2012-02-16 daveadams@gmail.com
# Last updated 2012-10-12 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require_relative 'testlib/helper'

module SakaiInfo
  class TestSakaiXMLEntitySubclass < SakaiXMLEntity
    # all we need is the initialize method to read in an ID and some XML
    # so that we can test the baseline methods and attributes of the
    # SakaiXMLEntity class
    def initialize(id, xml)
      @id = id
      @xml = xml
      parse_xml
    end
  end
end

class Util
  def self.enc64(s)
    Base64.encode64(s).chomp
  end
end


class SakaiXMLEntityTest < MiniTest::Unit::TestCase
  # define some raw data
  BasicData = {
    "id" => "id1",
    "title" => "title",
    "order" => "4",
    "number" => "10",
    "created_by" => "mzaldiva",
    "modified_by" => "dmcphers"
  }
  BasicObject = {
    "id" => BasicData["id"],
    "xml" => "<?xml version='1.0' encoding='UTF-8'?>
<testobject title='#{BasicData["title"]}' id='#{BasicData["id"]}' order='#{BasicData["order"]}'>
  <properties>
      <property enc='BASE64' name='CHEF:creator' value='#{Util.enc64(BasicData["created_by"])}'/>
      <property enc='BASE64' name='CHEF:modifiedby' value='#{Util.enc64(BasicData["modified_by"])}'/>
      <property enc='BASE64' name='DAV:getlastmodified' value='MjAxMTA2MDgyMDUxMDY0MDk='/>
      <property enc='BASE64' name='DAV:creationdate' value='MjAxMTA1MDQxODA4MzcxMzE='/>
      <property enc='BASE64' name='number' value='#{Util.enc64(BasicData["number"])}'/>
      <property enc='BASE64' name='empty' value=''/>
  </properties>
</testobject>" }

  # TODO: restore test_parse_xml
  # def test_parse_xml
  #   # test the simplest working case
  #   entity = nil
  #   assert_nothing_raised do
  #     entity = SakaiInfo::TestSakaiXMLEntitySubclass.new(BasicObject["id"], BasicObject["xml"])
  #   end

  #   # check automated attributes
  #   assert_equal(BasicData["id"], entity.id)
  #   # TODO: figure out how best to test lookup data -- eg user info as in below
  #   # assert_equal(BasicData["created_by"], entity.created_by)
  #   # assert_equal(BasicData["modified_by"], entity.modified_by)

  #   # check property passthrough
  #   assert_equal(BasicData["number"], entity.properties["number"])
  #   assert_equal(BasicData["created_by"], entity.properties["CHEF:creator"])
  #   assert_equal(BasicData["modified_by"], entity.properties["CHEF:modifiedby"])
  #   assert_equal("", entity.properties["empty"])

  #   # check attribute passthrough
  #   assert_equal(BasicData["order"], entity.attributes["order"])
  #   assert_equal(BasicData["title"], entity.attributes["title"])
  #   assert_equal(BasicData["id"], entity.attributes["id"])

  #   # TODO: test more complex cases, other encodings
  #   # TODO: test broken data
  # end

  def test_serialization
    # TODO: test serialization methods
  end
end


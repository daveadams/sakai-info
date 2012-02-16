# test_sakai_xml_entity.rb
#   Tests for SakaiInfo::SakaiXMLEntity
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

class SakaiXMLEntityTest < Test::Unit::TestCase
  # define some raw data
  BasicObject =
    ["id1","<?xml version='1.0' encoding='UTF-8'?>
<testobject title='Test Object' id='id1' order='4'>
  <properties>
      <property enc='BASE64' name='CHEF:creator' value='YTU4MGYxZGEtZTBmNi00ZGE2LTgwM2YtOWU5ZTc2ZTlhODBm'/>
      <property enc='BASE64' name='CHEF:modifiedby' value='YTU4MGYxZGEtZTBmNi00ZGE2LTgwM2YtOWU5ZTc2ZTlhODBm'/>
      <property enc='BASE64' name='DAV:getlastmodified' value='MjAxMTA2MDgyMDUxMDY0MDk='/>
      <property enc='BASE64' name='DAV:creationdate' value='MjAxMTA1MDQxODA4MzcxMzE='/>
      <property enc='BASE64' name='number' value='MTA='/>
      <property enc='BASE64' name='empty' value=''/>
  </properties>
</testobject>"]

  def test_parse_xml
    # test the simplest working case
    entity = nil
    assert_nothing_raised do
      entity = SakaiInfo::TestSakaiXMLEntitySubclass.new(*BasicObject)
    end

    # TODO: test more complex cases, other encodings
    # TODO: test broken data
  end

  def test_serialization
    # TODO: test serialization methods
  end
end


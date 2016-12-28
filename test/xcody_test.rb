require 'minitest'
require 'minitest/unit'
require 'minitest/autorun'

require './lib/xcody'

class XcodyTest < Minitest::Test
  def setup
    @xcody = Xcody.new
  end

  def test_with_default
    assert_equal [], @xcody.xcode_build_cmd
  end

  def test_with_some_values
    @xcody.xcode_build.project("project.xcworkspace").target("target").build
    assert_equal %(/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -workspace project.xcworkspace -target target build), @xcody.command
  end
end
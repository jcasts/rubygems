#--
# Copyright 2006 by Chad Fowler, Rich Kilmer, Jim Weirich and others.
# All rights reserved.
# See LICENSE.txt for permissions.
#++

require 'test/unit'
require 'test/gemutilities'
require 'rubygems/builder'

class TestGemBuilder < RubyGemTestCase

  def test_build
    builder = Gem::Builder.new quick_gem('a')

    use_ui @ui do
      Dir.chdir @tempdir do
        builder.build
      end
    end

    assert_match %r|Successfully built RubyGem\n  Name: a|, @ui.output
  end

  def test_build_invalid_spec
    builder = Gem::Builder.new Gem::Specification.new

    e = assert_raises Gem::InvalidSpecificationException do
      builder.build
    end

    assert_equal 'Missing value for attribute name', e.message
  end

end

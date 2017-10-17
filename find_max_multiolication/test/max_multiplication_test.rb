require 'test_helper'

class TestFindMaxMultiplication < Minitest::Test
  attr_reader :find

  def setup
    @find = FindMaxMultiplication.new
  end

  def test_without_digits
    result = find.result('sfsdfdsf')

    assert_equal nil, result
  end

  def test_with_digits
    result = find.result('sf1234sdsd222234sd345fdfd5522')

    assert_equal 100, result
  end

  def test_without_string
    result = find.result(['as', 23, 1, 'we'])

    assert_equal nil, result
  end
end

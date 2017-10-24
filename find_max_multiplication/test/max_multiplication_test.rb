require 'test_helper'

class TestFindMaxMultiplication < Minitest::Test
  def test_without_digits
    result = FindMaxMultiplication.new('sfsdfdsf').result

    assert_nil nil, result
  end

  def test_with_digits
    result = FindMaxMultiplication.new('sf1234sdsd222234sd345fdfd5522').result

    assert_equal 100, result
  end

  def test_without_string
    result = FindMaxMultiplication.new(['as', 23, 1, 'we']).result

    assert_nil nil, result
  end
end

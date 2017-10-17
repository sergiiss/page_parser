require 'test_helper'

class TestBinarySorting < Minitest::Test
  attr_reader :binary_sort

  def setup
    @binary_sort = BinarySorting.new
  end

  def test_sorting1
    result = binary_sort.result([3, 7, 8, 9])

    assert_equal [8, 3, 9, 7], result
  end

  def test_sorting2
    result = binary_sort.result([3, 7, 8, 10, 12])

    assert_equal [8, 3, 10, 12, 7], result
  end

  def test_sorting3
    result = binary_sort.result([1, 7, 9, 17, 33, 45, 59])

    assert_equal [1, 9, 17, 33, 7, 45, 59], result
  end
end

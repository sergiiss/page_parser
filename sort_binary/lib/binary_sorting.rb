class BinarySorting
  def initialize
    @binary_representation = []
    @sorted_binary_data    = []
    @max_count_units       = 0
  end

  def result(input_data)
    get_binary_representation(input_data)
    get_collection_with_sum
    sort_binary_data
    convert_to_decimal
  end

  private

  attr_reader :binary_representation, :collection_of_amounts, :sorted_binary_data, :max_count_units

  def get_binary_representation(input_data)
    @binary_representation = input_data.map do |index|
      index.to_s(2)
    end
  end

  def get_collection_with_sum
    sum_binary = 0

    @collection_of_amounts = Hash.new.tap do |f|
      binary_representation.map do |string|
        string.each_char { |index| sum_binary += index.to_i }
        f[string] = sum_binary

        calculate_max_amount(sum_binary)
        sum_binary = 0
      end
    end
  end

  def calculate_max_amount(sum_binary)
    if max_count_units < sum_binary
      @max_count_units = sum_binary
    end
  end

  def sort_binary_data
    index = 0

    while index <= max_count_units
      binary_representation.each do |x|
        if collection_of_amounts[x] == index
          @sorted_binary_data << x
        end
      end
      index += 1
    end

    sorted_binary_data
  end

  def convert_to_decimal
    sorted_binary_data.map { |f| f.to_i(2)}
  end
end

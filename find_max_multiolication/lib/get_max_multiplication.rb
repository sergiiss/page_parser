class FindMaxMultiplication
  attr_reader :collection_combinations, :max_multiplication, :multiplication

  def initialize
    @collection_combinations = []
    @max_multiplication      = 0
    @multiplication          = 1
  end

  def result(string)
    if string.class == String
      find_combimations(string)
      combine_the_results
      get_result
    else
      @max_multiplication = nil
    end

    max_multiplication
  end

  private

  def find_combimations(string)
    while string.length > 3
      @collection_combinations << string.scan(/[\.|\n]*(\d{4})[\.|\n]*/)
      string = string[1..-1]
    end
  end

  def get_result
    if collection_combinations.empty?
      @max_multiplication = nil
    else
      @collection_combinations = collection_combinations.uniq
      get_multiplication_max
    end
  end

  def combine_the_results
    @collection_combinations.flatten!
  end

  def get_multiplication_max
    collection_combinations.each do |digits|
      @multiplication = 1
      digits.each_char { |digit| @multiplication *= digit.to_i }

      if @max_multiplication < multiplication
        @max_multiplication = multiplication
      end
    end
  end
end

class FindMaxMultiplication
  attr_reader :input, :max_multiplication

  def initialize(input)
    @max_multiplication = nil
    @input = input

    @collection_mult    = []
  end

  def result
    get_max_multiplication
  end

  private

  attr_reader :collection_mult

  def get_max_multiplication
    if input.class == String
      input.scan(/\d{4,}/).map {|f| f.split('').each_cons(4) {|x| @collection_mult << x.inject(1) { |mem, var| mem*(var).to_i }}}
      @max_multiplication = collection_mult.max unless collection_mult.empty?
    end

    max_multiplication
  end
end

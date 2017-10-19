class FindMaxMultiplication
  attr_reader :collection_mult, :max_multiplication

  def initialize
    @collection_mult    = []
    @max_multiplication = nil
  end

  def result(input)
    if input.class == String
      input.scan(/\d{4,}/).map {|f| f.split('').each_cons(4) {|x| @collection_mult << x.inject(1) { |mem, var| mem*(var).to_i }}}
      @max_multiplication = collection_mult.max unless collection_mult.empty?
    end

    max_multiplication
  end
end

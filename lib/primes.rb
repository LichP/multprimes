module Primes
  class << self
    
    # Find the first +count+ prime numbers.
    #
    # @param [Integer] count the number of primes to find
    # @return [Array<Integer>] if +count+ is a positive integer
    # @return [nil] otherwise
    def first(count)
      return nil unless count.kind_of?(Integer) && count > 0
      
      # To find +count+ primes, we need to sieve a set of integers large enough
      # to contain +count+ primes, i.e. +n : pi(n) == count+. Use 
      sieve = (2..count).to_a
    end

    # Create an initial sieve containing the first +count+ prime numbers.
    #
    # @param [Integer] count the number of primes to be contained in the sieve
    # @return [Array<Integer>] if +count+ is a positive integer
    # @return [nil] otherwise
    def initial_sieve_for(count)
      return nil unless count.kind_of?(Integer) && count > 0
      
      # To find +count+ primes, we need to sieve a set of integers large enough
      # to contain +count+ primes. We use the upper bound nth prime < n * (ln n  +
      # ln ln n) for n >= 6
      bound = if count >= 6
        (
          (
            Math.log(count) + Math.log(Math.log(count))
          ) * count
        ).ceil
      else
        12
      end

      (2..bound).to_a
    end
  end
end

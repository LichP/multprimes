module Primes
  class << self
    
    # Find the first +count+ prime numbers.
    #
    # @param [Integer] count the number of primes to find
    # @return [Array<Integer>] if +count+ is a positive integer
    # @return [nil] otherwise
    def first(count)
      return nil unless count.kind_of?(Integer) && count > 0
      
      # First get a sieve big enough to contain +count+ primes
      sieve = self.initial_sieve_for(count)
      
      # Sieve of Eratosthenes: we proceed through each number in the sieve.
      # For each number, we remove every multiple of that number. Any numbers
      # which remain are therefore prime. We edit the sieve in place, so .each
      # will not pick up already removed numbers e.g. 4 is a multiple of 2, so
      # will already be removed by the time .each performs its third iteration.
      # We're also exploiting the fact that our sieve starts with a known
      # prime (2).
      sieve.each do |prime|
        # As a minor optimization, we check +n != prime+ second, so we're only
        # checking this for multiples of +prime+ rather than every remaining
        # element in the array
        sieve.reject! { |n| n % prime == 0 && n != prime}
      end
      
      # Our sieve is now guaranteed to contain at least +count+ primes, but
      # may contain more, so we return the first +count+ elements only
      sieve.first(count)
    end

    # Create an initial sieve containing the first +count+ prime numbers.
    #
    # @param [Integer] count the number of primes to be contained in the sieve
    # @return [Array<Integer>] if +count+ is a positive integer
    # @return [nil] otherwise
    def initial_sieve_for(count)
      return nil unless count.kind_of?(Integer) && count > 0
      
      # To find +count+ primes, we need to sieve a set of integers large enough
      # to contain +count+ primes. We use the upper bound nth prime < n * (ln n
      # + ln ln n) for n >= 6
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

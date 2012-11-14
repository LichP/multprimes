require File.join(File.dirname(__FILE__), '..', 'lib', 'primes')

describe Primes do
  describe ".first(n)" do
    it "should return nil if n is not a positive integer" do
      Primes.first("three").should be_nil
      Primes.first(-1).should      be_nil
      Primes.first(0).should       be_nil
    end
    
    it "should return the first n primes (n = 3, n = 10)" do
      Primes.first(3).should == [2, 3, 5]
      Primes.first(10).should == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]      
    end
    
    it "should return a 100 element array starting with 2 and ending with 541 (n = 100)" do
      primes = Primes.first(100)
      primes.length.should == 100
      primes.first.should  == 2
      primes.last.should   == 541
    end

    it "should return a 1000 element array ending with 7919 (n = 1000)" do
      primes = Primes.first(1000)
      primes.length.should == 1000
      primes.last.should   == 7919
    end
  end
  
  describe ".initial_sieve_for(n)" do
    it "should return nil if n is not a positive integer" do
      Primes.initial_sieve_for("three").should be_nil
      Primes.initial_sieve_for(-1).should      be_nil
      Primes.initial_sieve_for(0).should       be_nil
    end
    
    it "should return [2..12] for n < 6" do
      sieve = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
      1.upto(5) { |i| Primes.initial_sieve_for(i).should == sieve }
    end
    
    it "should return [2..15] for n == 6" do
      Primes.initial_sieve_for(6).should == (2..15).to_a
    end
    
    it "should return [2..32] for n == 10" do
      Primes.initial_sieve_for(10).should == (2..32).to_a
    end
    
    it "should return [2..614] for n == 100" do
      Primes.initial_sieve_for(100).should == (2..614).to_a
    end
  end
end

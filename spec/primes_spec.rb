require File.join(File.dirname(__FILE__), '..', 'lib', 'primes')

describe Primes do
  describe ".first(n)" do
    it "should return nil if n is not a positive integer" do
      Primes.first("three").should be_nil
      Primes.first(-1).should      be_nil
      Primes.first(0).should       be_nil
    end
    
    it "should return the first n primes" do
      Primes.first(3).should == [2, 3, 5]
    end
  end
end

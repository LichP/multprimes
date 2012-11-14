require File.join(File.dirname(__FILE__), '..', 'lib', 'primes')

describe Primes do
  describe ".first(3)" do
    it "should return the first three primes" do
      Primes.first(3).should == [2, 3, 5]
    end
  end
end

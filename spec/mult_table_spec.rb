require File.join(File.dirname(__FILE__), '..', 'lib', 'mult_table')

describe MultTable do
  it "should have a multipliers attribute equal to an array of the initialization arguments" do
    MultTable.new([2, 3, 4, 5]).multipliers.should   == [2, 3, 4, 5]
    MultTable.new(2, 3, 4, 5).multipliers.should     == [2, 3, 4, 5]
    MultTable.new([2, [3, 4, 5]]).multipliers.should == [2, 3, 4, 5]
    MultTable.new("").multipliers.should             == [""]
    MultTable.new.multipliers.should                 == []
  end
  
  describe "#line(i)" do
    it "should return an array equal to #mutipliers when i = 0" do
      mt = MultTable.new(2, 3, 4, 5)
      mt.line(0).should == mt.multipliers
    end
    
    it "should return nil if i > number of multipliers" do
      MultTable.new(2, 3, 4, 5).line(12).should be_nil
    end
  
    it "should return an array consisting of the result of each element of #multipliers having its * method called with the ith multiplier as it's argument" do
      MultTable.new(2, 3, 4, 5).line(3).should == [8, 12, 16, 20]
    end
  end
  
  describe "#header_line" do
    it "should be identical to #multipliers" do
      mt = MultTable.new(2, 3, 4, 5)
      mt.header_line.should == mt.multipliers
    end
  end
end

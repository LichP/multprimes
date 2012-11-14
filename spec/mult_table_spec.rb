require File.join(File.dirname(__FILE__), '..', 'lib', 'mult_table')

describe MultTable do
  it "should have a multipliers attribute equal to an array of the initialization arguments" do
    MultTable.new([2, 3, 4, 5]).multipliers.should   == [2, 3, 4, 5]
    MultTable.new(2, 3, 4, 5).multipliers.should     == [2, 3, 4, 5]
    MultTable.new([2, [3, 4, 5]]).multipliers.should == [2, 3, 4, 5]
    MultTable.new("").multipliers.should             == [""]
    MultTable.new.multipliers.should                 == []
  end
  
  it "should arrange multipliers in ascending order" do
    MultTable.new(4,2,7,3).multipliers.should == [2, 3, 4, 7]
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
  
  describe "#largest_product" do
    it "should return the largest product in the table" do
      MultTable.new(2, 3, 4, 5).largest_product.should == 25
    end
  end
  
  describe "Formatter" do
    mt = MultTable.new(2, 3)
    formatter = MultTable::Formatter.new(mt)
  
    describe "#header" do
      it "should return a string representation of MultTable#header_line" do
        formatter.header.should == "[2, 3]\n"
      end
    end
    
    describe "#build_line(multiplier, products)" do
      it "should return a string representation of it arguments" do
        formatter.build_line(2, [3, 4]).should == "2: [3, 4]\n"
      end
    end
  
    describe "#output" do
      it "should create output consisting of the result of #header concatenated with the result of iterating #mult_table.lines into #build_line" do
        formatter.output.should == "[2, 3]\n2: [4, 6]\n3: [6, 9]\n"
      end
    end
  end
  
  describe "CsvFormatter" do
    it "should format a MultTable as a CSV" do
      mt = MultTable.new(2, 3, 4)
      MultTable::CsvFormatter.new(mt).output.should == ",2,3,4\r\n2,4,6,8\r\n3,6,9,12\r\n4,8,12,16\r\n"
    end
  end
  
  describe "ScreenFromatter" do
    it "should format MultTable for screen output" do
      mt = MultTable.new(2, 3, 4)
      MultTable::ScreenFormater.new(mt).output.should == <<SCREEN_OUTPUT
  |  2  3  4
--+---------
 2|  4  6  8
 3|  6  9 12
 4|  8 12 16
SCREEN_OUTPUT
    end
  end
end

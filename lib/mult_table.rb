require File.join(File.dirname(__FILE__), 'mult_table', 'formatters')

class MultTable
  attr :multipliers

  def initialize(*multipliers)
    @multipliers = multipliers.flatten.sort
  end
  
  # Compute a line of the multiplication table
  #
  # @param [Integer] i the number of the line to compute
  # @return [Array<Integer>] of products calculated from the +i+th multiplier
  # @return [Array<Integer>] of untouched multipliers if +i = 0+
  # @return [nil] if +i+ is out of range or otherwise invalid
  def line(i)
    case i
      when 0
        self.multipliers
      when 1..self.multipliers.length
        self.multipliers.map { |m| m * self.multipliers[i - 1] }
      else
        nil
    end
  end
  
  # @return #line(0)
  def header_line
    self.line(0)
  end
  
  # Generate all lines in the multiplication table (except for the header)
  #
  # @return [Array<Integer, Array<Integer>] an array of lines, each line
  # consisting of the multiplier and an array of products of that multiplier
  def lines
    1.upto(multipliers.length).collect do |i|
      [self.multipliers[i - 1], self.line(i)]
    end
  end
  
  # @return [Integer] the largest product in the table, i.e. the square of
  # the last (therefore largest) multiplier
  def largest_product
    self.multipliers.last ** 2
  end
end

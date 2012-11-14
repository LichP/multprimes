require File.join(File.dirname(__FILE__), 'mult_table', 'formatters')

class MultTable
  attr :multipliers

  def initialize(*multipliers)
    @multipliers = multipliers.flatten.sort
  end
  
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
  
  def header_line
    self.line(0)
  end
  
  def lines
    1.upto(multipliers.length).collect do |i|
      [self.multipliers[i - 1], self.line(i)]
    end
  end
  
  def largest_product
    self.multipliers.last ** 2
  end
end

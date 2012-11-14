class MultTable
  class Formatter
    attr_reader :mult_table
  
    def initialize(mult_table)
      @mult_table = mult_table
    end
    
    def header
      self.mult_table.header_line.to_s + "\n"
    end
    
    def build_line(multiplier, products)
      multiplier.to_s + ": " + products.to_s + "\n"
    end
    
  
    def output
      result = self.header
      self.mult_table.lines.each do |multiplier, products|
        result << self.build_line(multiplier, products)
      end
      result
    end
  end
  
  class CsvFormatter < Formatter
    def header
      ',' + self.mult_table.header_line.join(',') + "\r\n"
    end
  
    def build_line(multiplier, products)
      "#{multiplier}," + products.join(',') + "\r\n"
    end
  end

  attr :multipliers

  def initialize(*multipliers)
    @multipliers = multipliers.flatten
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
end

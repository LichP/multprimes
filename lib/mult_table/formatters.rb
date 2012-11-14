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
  
  class ScreenFormatter < Formatter
    def field_width
      @field_width ||= self.mult_table.largest_product.to_s.length + 1
    end
  
    def pad_number(n)
      n.to_s.rjust(self.field_width, ' ')
    end
    
    def header
      line = "#{self.pad_number('')}|" + self.mult_table.header_line.map{ |n| self.pad_number(n) }.join + "\n"
      dashes = ("-" * (line.length - 1)) << "\n"
      line + dashes.sub(/(?<=^-{#{self.field_width}})-/, "+")
    end
    
    def build_line(multiplier, products)
      "#{self.pad_number(multiplier)}|" + products.map{ |n| self.pad_number(n) }.join + "\n"
    end
  end
end

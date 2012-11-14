class MultTable
  # Use the Strategy Pattern to format multiplication tables. The +Formatter+
  # class implements a simple interface for outputting a multiplication table.
  # A formatter is initialized with the target table, and formatted with
  # #output. Different output formats can be achieved by subclassing
  # +Formatter+ and overriding the #header and #build_line methods
  class Formatter
    attr_reader :mult_table
  
    def initialize(mult_table)
      @mult_table = mult_table
    end
    
    # The header method returns the header row of the multiplication table,
    # which should consist of the the multipliers plus any header specific
    # formatting. This method is expected to be overriden by subclasses. A
    # default implementation is provided to facilitate testing #output.
    #
    # @return [String] the formatted multiplication table header
    def header
      self.mult_table.header_line.to_s + "\n"
    end
    
    # The build_line method returns a single line of the multiplication
    # table. This method is expected to be overriden by subclasses. A
    # default implementation is provided to facilitate testing #output.
    #
    # @param [Integer] multiplier the multiplier for the line
    # @param [Array<Integer>] products the products of +multiplier+
    # @return [String] the formatted line
    def build_line(multiplier, products)
      multiplier.to_s + ": " + products.to_s + "\n"
    end
    
    # @return [String] the complete formatted multiplication table.
    def output
      result = self.header
      self.mult_table.lines.each do |multiplier, products|
        result << self.build_line(multiplier, products)
      end
      result
    end
  end
  
  # Implements a CSV formatter
  class CsvFormatter < Formatter
    def header
      ',' + self.mult_table.header_line.join(',') + "\r\n"
    end
  
    def build_line(multiplier, products)
      "#{multiplier}," + products.join(',') + "\r\n"
    end
  end
  
  # Implements a screen formatter
  class ScreenFormatter < Formatter
    # Helper to determine the width of the columns. Columns must be wide
    # enough to accommodate the largest product in the table.
    #
    # @return [Integer] width of a field (or column)
    def field_width
      @field_width ||= self.mult_table.largest_product.to_s.length + 1
    end
  
    # Helper to pad numbers with spaces to the width of the column
    #
    # @param [Integer] n the number to pad
    # @return [String] +n+ padded with leading spaces to length #field_width
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

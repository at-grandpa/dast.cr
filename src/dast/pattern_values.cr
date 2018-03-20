require "./pattern_values/*"

module Dast
  abstract class PatternValues
    def initialize(@input : String | Nil)
    end

    abstract def pattern
    abstract def pattern_keys
    abstract def invalid_format_exception

    def match_values
      input = @input
      raise invalid_format_exception if input.nil?
      match = input.match(pattern)
      raise invalid_format_exception if match.nil?
      ret = [] of String
      pattern_keys.each do |key|
        value = match.to_h[key]?
        raise invalid_format_exception if value.nil?
        ret << value
      end
      ret
    end
  end
end

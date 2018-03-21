require "./pattern_values/*"

module Dast
  abstract class PatternValues
    def initialize(@input : String | Nil)
    end

    abstract def pattern
    abstract def invalid_format_exception

    def match_values
      input = @input
      raise invalid_format_exception if input.nil?
      match = input.match(pattern)
      raise invalid_format_exception if match.nil?
      ret = [] of String
      match.to_h.reject { |k, _| k == 0 }.each do |_, v|
        raise invalid_format_exception if v.nil?
        ret << v
      end
      ret
    end
  end
end

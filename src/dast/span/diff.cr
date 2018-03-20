module Dast
  abstract class Span
    class Diff < Span
      def pattern
        /\A(?<plus_minus>|\+|\~)(?<value>\d+)(?<unit>|[a-z]+?)\z/
      end

      def to_time_span : Time::MonthSpan | Time::Span
        match = @input.match(pattern)
        invalid_format! if match.nil?
        plus_minus = match.to_h["plus_minus"]?
        value = match.to_h["value"]?
        unit = match.to_h["unit"]?
        invalid_format! if plus_minus.nil?
        invalid_format! if value.nil?
        invalid_format! if unit.nil?
        case plus_minus
        when "+", ""
          diff = convert_time_span(value.to_i32 - 1, unit, {patterns: [""], default_time_span: (value.to_i32 - 1).day})
        else
          diff = convert_time_span((value.to_i32 - 1) * -1, unit, {patterns: [""], default_time_span: ((value.to_i32 - 1) * -1).day})
        end
        diff
      end

      def invalid_format!
        raise Exception.new("Invalid diff format. Please /[+-]\d(year|month|day|hour|minute|second)?/")
      end
    end
  end
end
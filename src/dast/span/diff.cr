module Dast
  abstract class Span
    class Diff < Span
      def pattern
        /\A(?<plus_minus>|\+|\~)(?<value>\d+)(?<unit>|[a-z]+?)\z/
      end

      def to_time_span : Time::MonthSpan | Time::Span
        input = @input
        invalid_format! if input.nil?
        match = input.match(pattern)
        invalid_format! if match.nil?
        plus_minus = match.to_h["plus_minus"]?
        value = match.to_h["value"]?
        unit = match.to_h["unit"]?
        invalid_format! unless !plus_minus.nil? && !value.nil? && !unit.nil?
        span_value = case plus_minus
                     when "+", "" then (value.to_i32 - 1)
                     else              (value.to_i32 - 1) * -1
                     end
        convert_time_span(span_value, unit, {patterns: [""], default_time_span: span_value.day})
      end

      def invalid_format!
        raise Exception.new("Invalid diff format. Please /[+-]\d(year|month|day|hour|minute|second)?/")
      end

      def add(time : Time)
        time + to_time_span
      end

      def diff?
        !!@input.try &.match(pattern)
      end
    end
  end
end

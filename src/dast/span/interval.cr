module Dast
  abstract class Span
    class Interval < Span
      def pattern
        /\A(?<value>\d+)(?<unit>|[a-z]+?)\z/
      end

      def pattern_keys
        ["value", "unit"]
      end

      def to_time_span : Time::MonthSpan | Time::Span
        value, unit = match_values
        convert_time_span(value.to_i32, unit)
      end

      def invalid_format_exception
        Exception.new("Invalid interval format. The format of the '--interval' is {Int}[year|y|month|mon|day|d|hour|h|minute|min|m|second|sec|s].")
      end
    end
  end
end

module Dast
  abstract class Span
    class Interval < Span
      def pattern
        /\A(?<value>\d+)(?<unit>|[a-z]+?)\z/
      end

      def to_time_span : Time::MonthSpan | Time::Span
        match = @input.match(pattern)
        invalid_format! if match.nil?
        value = match.to_h["value"]?
        unit = match.to_h["unit"]?
        invalid_format! if value.nil?
        invalid_format! if unit.nil?
        convert_time_span(value.to_i32, unit)
      end

      def invalid_format!
        raise Exception.new("Invalid interval format. The format of the '--interval' is {Int}[year|y|month|mon|day|d|hour|h|minute|min|m|second|sec|s].")
      end
    end
  end
end

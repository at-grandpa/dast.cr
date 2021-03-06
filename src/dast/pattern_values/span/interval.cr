module Dast
  abstract class PatternValues
    abstract class Span < PatternValues
      class Interval < Span
        def pattern
          /\A(?<value>\d+)(?<unit>|[a-z]+?)\z/
        end

        def invalid_format_exception
          DastException.new("Invalid interval format. The format of the '--interval' is {Int}[year|y|month|mon|day|d|hour|h|minute|min|m|second|sec|s].")
        end

        def to_time_span : Time::MonthSpan | Time::Span
          value, unit = match_values
          convert_time_span(value.to_i32, unit)
        end
      end
    end
  end
end

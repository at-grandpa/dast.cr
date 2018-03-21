module Dast
  abstract class PatternValues
    abstract class Span < PatternValues
      class Diff < Span
        def pattern
          /\A(?<plus_minus>|\+|\~)(?<value>\d+)(?<unit>|[a-z]+?)\z/
        end

        def pattern_keys
          ["plus_minus", "value", "unit"]
        end

        def to_time_span : Time::MonthSpan | Time::Span
          plus_minus, value, unit = match_values
          span_value = case plus_minus
                       when "+", "" then (value.to_i32 - 1)
                       else              (value.to_i32 - 1) * -1
                       end
          convert_time_span(span_value, unit, {patterns: [""], default_time_span: span_value.day})
        end

        def invalid_format_exception
          DastException.new("Invalid diff format. Please /[+~]\d(year|y|month|mon|day|d||hour|h|minute|min|m|second|sec|s)?/")
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
end

require "./span/*"

module Dast
  abstract class Span
    def initialize(@input : String | Nil)
    end

    abstract def pattern
    abstract def pattern_keys
    abstract def to_time_span
    abstract def invalid_format_exception

    def convert_time_span(
      value : Int32,
      unit : String,
      default : NamedTuple(patterns: Array(String), default_time_span: Time::MonthSpan | Time::Span) | Nil = nil
    )
      case unit
      when "year", "y"
        value.year
      when "month", "mon"
        value.month
      when "day", "d"
        value.day
      when "hour", "h"
        value.hour
      when "minute", "min", "m"
        value.minute
      when "second", "sec", "s"
        value.second
      else
        return default[:default_time_span] if !default.nil? && default[:patterns].includes?(unit)
        raise invalid_format_exception
      end
    end
  end
end

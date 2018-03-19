module Dast
  class Interval
    def initialize(@str : String)
    end

    INTERVAL_PATTERN = /\A(?<value>\d+)(?<unit>|[a-z]+?)\z/

    def diff?(input)
      !!input.match(INTERVAL_PATTERN)
    end

    def value
      match = @str.match(INTERVAL_PATTERN)
      invalid_interval_format! if match.nil?
      value = match.to_h["value"]?
      unit = match.to_h["unit"]?
      invalid_interval_format! if value.nil?
      invalid_interval_format! if unit.nil?
      convert_time_span(value.to_i32, unit)
    end

    def convert_time_span(value : Int32, unit : String)
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
        invalid_interval_format!
      end
    end

    def invalid_interval_format!
      raise Exception.new("Invalid interval format. The format of the '--interval' is {Int}[year|y|month|mon|day|d|hour|h|minute|min|m|second|sec|s].")
    end
  end
end

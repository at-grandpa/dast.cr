module Dast
  class Interval
    def initialize(@str : String)
    end

    def value
      splitted = @str.split(".")
      invalid_interval_argument! if splitted.size != 2
      value, unit = splitted
      invalid_interval_argument! if value.to_i32?.nil?

      case unit
      when "year"
        value.to_i.year
      when "month"
        value.to_i.month
      when "day"
        value.to_i.day
      when "hour"
        value.to_i.hour
      when "minute"
        value.to_i.minute
      when "second"
        value.to_i.second
      else
        raise Exception.new("Only [year|month|day|hour|minute|second] is allowed for the interval unit. Not supported [#{unit}].")
      end
    end

    def invalid_interval_argument!
      raise Exception.new("Invalid 'interval' argument. The syntax of the '--interval' is {Int}.[year|month|day|hour|minute|second].")
    end
  end
end

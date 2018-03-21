module Dast
  class TimeFactory
    def self.create_times(now : Time, arguments : Array(String))
      time1, time2 = case arguments.size
                     when 0 then arguments_size_zero(now)
                     when 1 then arguments_size_one(now, arguments)
                     when 2 then arguments_size_two(now, arguments)
                     else        raise DastException.new("Wrong number of arguments. (given #{arguments.size}, expected 0 or 1 or 2)")
                     end

      time1 < time2 ? [time1, time2] : [time2, time1]
    end

    def self.arguments_size_zero(now : Time) : Tuple(Time, Time)
      return now, (now - 6.day) # 1 week ago.
    end

    def self.arguments_size_one(now : Time, arguments : Array(String)) : Tuple(Time, Time)
      arg = arguments.first?
      d = Dast::PatternValues::Span::Diff.new(arg)
      another = d.diff? ? d.add(now) : Time.parse(normalize_date_time(arg), "%Y-%m-%d %H:%M:%S")
      return now, another
    end

    def self.arguments_size_two(now : Time, arguments : Array(String)) : Tuple(Time, Time)
      arg1, arg2 = arguments
      diff1 = Dast::PatternValues::Span::Diff.new(arg1)
      diff2 = Dast::PatternValues::Span::Diff.new(arg2)
      case
      when diff1.diff?
        time2 = Time.parse(normalize_date_time(arg2), "%Y-%m-%d %H:%M:%S")
        time1 = diff1.add(time2)
      when diff2.diff?
        time1 = Time.parse(normalize_date_time(arg1), "%Y-%m-%d %H:%M:%S")
        time2 = diff2.add(time1)
      else
        time1 = Time.parse(normalize_date_time(arg1), "%Y-%m-%d %H:%M:%S")
        time2 = Time.parse(normalize_date_time(arg2), "%Y-%m-%d %H:%M:%S")
      end
      return time1, time2
    end

    def self.normalize_date_time(input)
      Dast::PatternValues::DateTime.new(input).normalize
    end
  end
end

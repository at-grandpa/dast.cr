module Dast
  class TimeFactory
    def self.create_times(now : Time, arguments : Array(String))
      time1, time2 = case arguments.size
                     when 0 then arguments_size_zero(now)
                     when 1 then arguments_size_one(now, arguments)
                     when 2 then arguments_size_two(now, arguments)
                     else        raise Exception.new("Wrong number of arguments. (given #{arguments.size}, expected 0 or 1 or 2)")
                     end

      from, to = time1 < time2 ? [time1, time2] : [time2, time1]
      return from, to
    end

    def self.arguments_size_zero(now : Time) : Tuple(Time, Time)
      time1 = now
      time2 = (time1 - 6.day) # 1 week ago.
      return time1, time2
    end

    def self.arguments_size_one(now : Time, arguments : Array(String)) : Tuple(Time, Time)
      arg = arguments.first?
      d = Dast::Span::Diff.new(arg)
      if d.diff?
        time1 = now
        time2 = d.add(time1)
      else
        time1 = now
        time2 = Time.parse(format_for_time(arg), "%Y-%m-%d %H:%M:%S")
      end
      return time1, time2
    end

    def self.arguments_size_two(now : Time, arguments : Array(String)) : Tuple(Time, Time)
      time_str1, time_str2 = arguments
      diff1 = Dast::Span::Diff.new(time_str1)
      diff2 = Dast::Span::Diff.new(time_str2)
      case
      when diff1.diff?
        time2 = Time.parse(format_for_time(time_str2), "%Y-%m-%d %H:%M:%S")
        time1 = diff1.add(time2)
      when diff2.diff?
        time1 = Time.parse(format_for_time(time_str1), "%Y-%m-%d %H:%M:%S")
        time2 = diff2.add(time1)
      else
        time1 = Time.parse(format_for_time(time_str1), "%Y-%m-%d %H:%M:%S")
        time2 = Time.parse(format_for_time(time_str2), "%Y-%m-%d %H:%M:%S")
      end
      return time1, time2
    end

    def self.pattern
      /\A(?<ymd>\d{4}[\/-]\d{2}[\/-]\d{2}) ?(?<hms>|\d{2}:\d{2}:\d{2})\z/
    end

    def self.format_for_time(input)
      invalid_time_format! if input.nil?
      match = input.match(pattern)
      invalid_time_format! if match.nil?
      ymd = match.to_h["ymd"]?
      hms = match.to_h["hms"]?
      invalid_time_format! if ymd.nil?
      invalid_time_format! if hms.nil?
      hms = hms.empty? ? "00:00:00" : hms
      converted_ymd = ymd.gsub(/\//, "-")
      converted_hms = hms.gsub(/::/, ":")
      converted_ymd + " " + converted_hms
    end

    def self.invalid_time_format!
      raise Exception.new("Invalid time format. Please [%Y-%m-%d] or [%Y/%m/%d] or [%Y-%m-%d %H:%M:%S]")
    end
  end
end

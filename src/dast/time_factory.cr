module Dast
  class TimeFactory
    def self.create_time_from_and_to(now : Time, arguments : Array(String))
      case arguments.size
      when 0
        # default
        time1 = now
        time2 = (now - 6.day) # 1 week ago.
      when 1
        arg = arguments.first?
        invalid_diff_format! if arg.nil?
        d = Dast::Span::Diff.new(arg)
        if d.diff?
          time1 = now
          time2 = d.add(time1)
        else
          time1 = now
          time2 = Time.parse(format_for_time(arg), "%Y-%m-%d %H:%M:%S")
        end
      when 2
        time_str1, time_str2 = arguments
        diff1 = Dast::Span::Diff.new(time_str1)
        diff2 = Dast::Span::Diff.new(time_str2)
        if diff1.diff?
          time2 = Time.parse(format_for_time(time_str2), "%Y-%m-%d %H:%M:%S")
          time1 = diff1.add(time2)
        elsif diff2.diff?
          time1 = Time.parse(format_for_time(time_str1), "%Y-%m-%d %H:%M:%S")
          time2 = diff2.add(time1)
        else
          time1 = Time.parse(format_for_time(time_str1), "%Y-%m-%d %H:%M:%S")
          time2 = Time.parse(format_for_time(time_str2), "%Y-%m-%d %H:%M:%S")
        end
      else
        raise Exception.new("Wrong number of arguments. (given #{arguments.size}, expected 0 or 1 or 2)")
      end

      if time1 < time2
        from, to = time1, time2
      else
        from, to = time2, time1
      end

      return from, to
    end

    def self.format_for_time(input)
      invalid_time_format! if input.nil?
      splitted = input.split(" ")
      if splitted.size == 1
        ymd = splitted.first?
        hms = "00:00:00"
      elsif splitted.size == 2
        ymd, hms = splitted
      else
        invalid_time_format!
      end
      invalid_time_format! if ymd.nil?
      invalid_time_format! if hms.nil?
      converted_ymd = ymd.gsub(/\//, "-")
      converted_hms = hms.gsub(/::/, ":")
      invalid_time_format! unless !!converted_ymd.match(/\d{4}-\d{2}-\d{2}/)
      invalid_time_format! unless !!converted_hms.match(/\d{2}:\d{2}:\d{2}/)
      converted_ymd + " " + converted_hms
    end

    def self.invalid_time_format!
      raise Exception.new("Invalid time format. Please [%Y-%m-%d] or [%Y/%m/%d] or [%Y-%m-%d %H:%M:%S]")
    end

    DIFF_PATTERN = /\A(?<plus_minus>|\+|\~)(?<value>\d+)(?<unit>|[a-z]+?)\z/

    def self.invalid_diff_format!
      raise Exception.new("Invalid diff format. Please /[+-]\d(year|month|day|hour|minute|second)?/")
    end
  end
end

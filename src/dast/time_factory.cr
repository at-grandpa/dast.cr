module Dast
  class TimeFactory
    def self.create_time_from_and_to(arguments : Array(String))
      case arguments.size
      when 0
        time_str1 = (Time.new - 3.day).to_s("%Y-%m-%d %H:%M:%S")
        time_str2 = Time.new.to_s("%Y-%m-%d %H:%M:%S")
      when 1
        time_str1 = arguments.first?
        # ここでtime_str1がdateかプラスマイナスかを判定する
        # if plus_minus?(time_str1)
        # else
        # end
        time_str2 = Time.new.to_s("%Y-%m-%d %H:%M:%S")
      when 2
        # どちらかがプラスマイナスだったら処理を分岐させる
        # どちらもプラスマイナスだったらraise
        time_str1, time_str2 = arguments
      else
        raise Exception.new("Wrong number of arguments. (given #{arguments.size}, expected 0 or 1 or 2)") unless arguments.size <= 2
      end
      raise Exception.new("time_str1.nil?") if time_str1.nil?
      raise Exception.new("time_str2.nil?") if time_str2.nil?
      time1 = Time.parse(format_for_time(time_str1), "%Y-%m-%d %H:%M:%S")
      time2 = Time.parse(format_for_time(time_str2), "%Y-%m-%d %H:%M:%S")
      if time1 < time2
        from, to = time1, time2
      else
        from, to = time2, time1
      end
      return from, to
    end

    def self.format_for_time(input)
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

    def self.split_diff(diff : String)
      match = diff.match(/\A(?<plus_minus>[+\-])(?<value>\d+)(?<unit>|[a-z]+?)\z/)
      invalid_diff_format! if match.nil?
      plus_minus = match.to_h["plus_minus"]?
      value = match.to_h["value"]?
      unit = match.to_h["unit"]?
      invalid_diff_format! if plus_minus.nil?
      invalid_diff_format! if value.nil?
      invalid_diff_format! if unit.nil?
      if plus_minus == "+"
        diff = convert_time_span(value.to_i32, unit)
      else
        diff = convert_time_span(value.to_i32 * -1, unit)
      end
      diff
    end

    def self.convert_time_span(value : Int32, unit : String)
      case unit
      when "year", "y"
        value.year
      when "month", "mon"
        value.month
      when "day", "d", ""
        value.day
      when "hour", "h"
        value.hour
      when "minute", "min" , "m"
        value.minute
      when "second", "sec", "s"
        value.second
      else
        raise Exception.new("Invalid diff format. Please /[+-]\d(year|month|day|hour|minute|second)?/")
      end
    end

    def self.calc_diff(time : Time, diff : String)
    end

    def self.invalid_diff_format!
      raise Exception.new("Invalid diff format. Please /[+-]\d(year|month|day|hour|minute|second)?/")
    end
  end
end

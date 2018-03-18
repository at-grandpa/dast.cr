module Dast
  class TimeFactory
    def self.create_time_from_and_to(arguments : Array(String))
      raise Exception.new("Wrong number of arguments. (given #{arguments.size}, expected 2)") unless arguments.size == 2
      time_str1, time_str2 = arguments
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
  end
end

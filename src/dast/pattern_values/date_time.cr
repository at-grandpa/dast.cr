module Dast
  abstract class PatternValues
    class DateTime < PatternValues
      def pattern
        /\A(?<ymd>\d{4}[\/-]\d{2}[\/-]\d{2}) ?(?<hms>|\d{2}:\d{2}:\d{2})\z/
      end

      def invalid_format_exception
        DastException.new("Invalid date format or diff format. See '--help'.")
      end

      def normalize
        ymd, hms = match_values
        converted_ymd = ymd.gsub(/\//, "-")
        converted_hms = hms.empty? ? "00:00:00" : hms
        converted_ymd + " " + converted_hms
      end
    end
  end
end

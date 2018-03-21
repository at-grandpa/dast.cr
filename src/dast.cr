require "./dast/**"
require "clim"

module Dast
  class Cli < Clim
    USAGE = <<-USAGE_MESSAGE
    dast [options] [arguments]

        -- arguments example --

        ex1) If no arguments, display last 1 week.

          $ dast
          '2018-03-15','2018-03-16', ... (last 1 week)

        ex2) If one date, display from specified date to now.

          $ dast 2018-03-10
          '2018-03-10','2018-03-11', ... '2018-03-21' (today)

            -- date format: [%Y-%m-%d] or [%Y/%m/%d] or [%Y-%m-%d %H:%M:%S]

        ex3) If one diff format, display from applied diff date to now.

          $ dast ~3day
          '2018-03-18','2018-03-19','2018-03-20','2018-03-21' (today)

            -- The minus sign is specified with "~".
            -- diff format: /(|+|~)\\d(year|y|month|mon|day|d||hour|h|minute|min|m|second|sec|s)?/

        ex4) If two date, display from date1 to date2.

          $ dast 2018-03-25 2018-03-27
          '2018-03-25','2018-03-26','2018-03-27'

        ex5) If date and diff format, display from applied diff date to date.

          $ dast 2018-03-27 ~3day
          '2018-03-24','2018-03-25','2018-03-26','2018-03-27'

        ex6) Interval, Format, Delimiter, Quote.

          $ dast '2018-03-21 12:00:00' 1h --interval=20min --format='%Y-%m-%d %H:%M:%S' --delimiter=' | ' --quote='"'
          "2018-03-21 12:00:00" | "2018-03-21 12:20:00" | "2018-03-21 12:40:00" | "2018-03-21 13:00:00"

    USAGE_MESSAGE

    main_command do
      desc "Date List."
      usage USAGE
      version Dast::VERSION, short: "-v"
      option "-i INTERVAL", "--interval INTERVAL", type: String, desc: "Interval. ({Int}[year|y|month|mon|day|d|hour|h|minute|min|m|second|sec|s])", default: "1day"
      option "-f FORMAT", "--format FORMAT", type: String, desc: "Date Format.", default: "%Y-%m-%d"
      option "-d DELIM", "--delimiter DELIM", type: String, desc: "Delimiter.", default: ","
      option "-q QUOTE", "--quote QUOTE", type: String, desc: "Quote.", default: "'"
      run do |options, arguments|
        print Dast::DateList.new(
          now: Time.new,
          interval: options.interval,
          format: options.format,
          delimiter: options.delimiter,
          quote: options.quote,
          arguments: arguments
        ).to_s
      rescue ex : DastException
        puts "ERROR: #{ex.message}"
      end
    end
  end
end

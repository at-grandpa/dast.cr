require "./dast/**"
require "clim"

module Dast
  class Cli < Clim
    main_command do
      desc "Date List."
      usage "dast [options] [arguments] ..."
      version Dast::VERSION, short: "-v"
      option "-i INTERVAL", "--interval INTERVAL", type: String, desc: "Interval. ({Int}[year|y|month|mon|day|d|hour|h|minute|min|m|second|sec|s])", default: "1day"
      option "-f FORMAT", "--format FORMAT", type: String, desc: "Date Format.", default: "%F"
      option "-d DELIM", "--delimiter DELIM", type: String, desc: "Delimiter.", default: ","
      option "-q QUOTE", "--quote QUOTE", type: String, desc: "Quote.", default: "'"
      run do |options, arguments|
        puts Dast::DateList.new(
          now: Time.new,
          interval: options.interval,
          format: options.format,
          delimiter: options.delimiter,
          quote: options.quote,
          arguments: arguments
        ).to_s
      end
    end
  end
end

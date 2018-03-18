require "./dast/**"
require "clim"

module Dast
  class Cli < Clim
    main_command do
      desc "Date List."
      usage "dast [options] [arguments] ..."
      version Dast::VERSION, short: "-v"
      option "-d DELIM", "--delimiter DELIM", type: String, desc: "Delimiter.", default: ","
      option "-q QUOTE", "--quote QUOTE", type: String, desc: "Quote.", default: "'"
      option "-f FORMAT", "--format FORMAT", type: String, desc: "Date Format.", default: "%F"
      option "-i INTERVAL", "--interval INTERVAL", type: String, desc: "Interval. ({Int}.[year|month|day|hour|minute|second])", default: "1.day"
      run do |options, arguments|
        # [done] オプションから日付オブジェクト２つを返す
        # 特別なオプションからフォーマットを返す
        # クリップボード
        # 各初期値
        # +3 とか
        # あれがなかったらとか
        # [done] interval
        # [done] 日付オブジェクト２つを入れて、フォーマット指定して、delimiterとquote指定したら返す
        # テストで、「returns hoge」のhogeをexpectにする
        from, to = Dast::TimeFactory.create_time_from_and_to(arguments)
        puts Dast::Display.new(
          from: from,
          to: to,
          interval: Dast::Interval.new(options.interval).value,
          format: options.format,
          delimiter: options.delimiter,
          quote: options.quote
        ).display
      end
    end
  end
end

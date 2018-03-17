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
      option "-f FORMAT", "--format FORMAT", type: String, desc: "Date Format.", default: ""
      run do |options, arguments|
        puts options
        puts arguments
        # オプションから日付オブジェクト２つを返す
        # 特別なオプションからフォーマットを返す
        # クリップボード
        # 日付オブジェクト２つを入れて、フォーマット指定して、delimiterとquote指定したら返す
      end
    end
  end
end

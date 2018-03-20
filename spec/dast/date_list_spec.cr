require "../spec_helper"

describe Dast::DateList do
  describe "#to_s" do
    [
      {
        interval:  "1d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20", "2018-03-23"],
        expect:    "'2018-03-20 00:00:00','2018-03-21 00:00:00','2018-03-22 00:00:00','2018-03-23 00:00:00'",
      },
      {
        interval:  "2d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20", "2018-03-25"],
        expect:    "'2018-03-20 00:00:00','2018-03-22 00:00:00','2018-03-24 00:00:00'",
      },
      {
        interval:  "2d",
        format:    "%F",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20", "2018-03-25"],
        expect:    "'2018-03-20','2018-03-22','2018-03-24'",
      },
      {
        interval:  "2d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: " | ",
        quote:     "'",
        arguments: ["2018-03-20", "2018-03-25"],
        expect:    "'2018-03-20 00:00:00' | '2018-03-22 00:00:00' | '2018-03-24 00:00:00'",
      },
      {
        interval:  "2d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "\"",
        arguments: ["2018-03-20", "2018-03-25"],
        expect:    "\"2018-03-20 00:00:00\",\"2018-03-22 00:00:00\",\"2018-03-24 00:00:00\"",
      },
      {
        interval:  "2d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018/03/20", "2018/03/25"],
        expect:    "'2018-03-20 00:00:00','2018-03-22 00:00:00','2018-03-24 00:00:00'",
      },
      {
        interval:  "2d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018/03/20 00:00:00", "2018/03/25 00:00:00"],
        expect:    "'2018-03-20 00:00:00','2018-03-22 00:00:00','2018-03-24 00:00:00'",
      },
      {
        interval:  "1y",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20 00:00:00", "2020-03-20 00:00:00"],
        expect:    "'2018-03-20 00:00:00','2019-03-20 00:00:00','2020-03-20 00:00:00'",
      },
      {
        interval:  "1mon",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20 00:00:00", "2018-05-20 02:00:00"],
        expect:    "'2018-03-20 00:00:00','2018-04-20 00:00:00','2018-05-20 00:00:00'",
      },
      {
        interval:  "1d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20 00:00:00", "2018-03-22 00:00:00"],
        expect:    "'2018-03-20 00:00:00','2018-03-21 00:00:00','2018-03-22 00:00:00'",
      },
      {
        interval:  "1h",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20 00:00:00", "2018-03-20 02:00:00"],
        expect:    "'2018-03-20 00:00:00','2018-03-20 01:00:00','2018-03-20 02:00:00'",
      },
      {
        interval:  "1m",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20 00:00:00", "2018-03-20 00:02:00"],
        expect:    "'2018-03-20 00:00:00','2018-03-20 00:01:00','2018-03-20 00:02:00'",
      },
      {
        interval:  "1s",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20 00:00:00", "2018-03-20 00:00:02"],
        expect:    "'2018-03-20 00:00:00','2018-03-20 00:00:01','2018-03-20 00:00:02'",
      },
      {
        interval:  "1d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20", "2"],
        expect:    "'2018-03-20 00:00:00','2018-03-21 00:00:00','2018-03-22 00:00:00'",
      },
      {
        interval:  "1d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2", "2018-03-20"],
        expect:    "'2018-03-20 00:00:00','2018-03-21 00:00:00','2018-03-22 00:00:00'",
      },
      {
        interval:  "1d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20", "+2"],
        expect:    "'2018-03-20 00:00:00','2018-03-21 00:00:00','2018-03-22 00:00:00'",
      },
      {
        interval:  "1d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20", "+2d"],
        expect:    "'2018-03-20 00:00:00','2018-03-21 00:00:00','2018-03-22 00:00:00'",
      },
      {
        interval:  "1d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20", "+2day"],
        expect:    "'2018-03-20 00:00:00','2018-03-21 00:00:00','2018-03-22 00:00:00'",
      },
      {
        interval:  "1d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20", "~2"],
        expect:    "'2018-03-18 00:00:00','2018-03-19 00:00:00','2018-03-20 00:00:00'",
      },
      {
        interval:  "1m",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20 00:00:00", "~2m"],
        expect:    "'2018-03-19 23:58:00','2018-03-19 23:59:00','2018-03-20 00:00:00'",
      },
      {
        interval:  "8d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20 00:00:00", "~2mon"],
        expect:    "'2018-01-20 00:00:00','2018-01-28 00:00:00','2018-02-05 00:00:00','2018-02-13 00:00:00','2018-02-21 00:00:00','2018-03-01 00:00:00','2018-03-09 00:00:00','2018-03-17 00:00:00'",
      },
    ].each do |spec_case|
      describe "returns #{spec_case[:expect]}, " do
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          Dast::DateList.new(
            interval: spec_case[:interval],
            format: spec_case[:format],
            delimiter: spec_case[:delimiter],
            quote: spec_case[:quote],
            arguments: spec_case[:arguments]
          ).to_s.should eq spec_case[:expect]
        end
      end
    end
    # describe "raises an Exception, " do
    #   [
    #     {
    #       arguments: ["2018-03-18", "2018-03-19", "2018-03-20"],
    #     },
    #   ].each do |spec_case|
    #     it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
    #       expect_raises(Exception, "Wrong number of arguments. (given #{spec_case[:arguments].size}, expected 0 or 1 or 2)") do
    #         Dast::TimeFactory.create_time_from_and_to(arguments: spec_case[:arguments])
    #       end
    #     end
    #   end
    # end
  end
end

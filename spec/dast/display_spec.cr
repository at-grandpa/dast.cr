require "../spec_helper"

describe Dast::Display do
  describe "#display" do
    describe "returns date list string, " do
      [
        {
          from:      Time.parse("2018-03-16", "%F"),
          to:        Time.parse("2018-03-18", "%F"),
          interval:  1.day,
          format:    "%Y-%m-%d",
          delimiter: ",",
          quote:     "'",
          expect:    "'2018-03-16','2018-03-17','2018-03-18'",
        },
        {
          from:      Time.parse("2018-03-17", "%F"),
          to:        Time.parse("2018-03-18", "%F"),
          interval:  4.hour,
          format:    "%Y-%m-%d %H:%M:%S",
          delimiter: ",",
          quote:     "'",
          expect:    "'2018-03-17 00:00:00','2018-03-17 04:00:00','2018-03-17 08:00:00','2018-03-17 12:00:00','2018-03-17 16:00:00','2018-03-17 20:00:00','2018-03-18 00:00:00'",
        },
        {
          from:      Time.parse("2018-03-18 00:00:00", "%Y-%m-%d %H:%M:%S"),
          to:        Time.parse("2018-03-18 00:05:00", "%Y-%m-%d %H:%M:%S"),
          interval:  1.minute,
          format:    "%Y-%m-%d %H:%M:%S",
          delimiter: ",",
          quote:     "'",
          expect:    "'2018-03-18 00:00:00','2018-03-18 00:01:00','2018-03-18 00:02:00','2018-03-18 00:03:00','2018-03-18 00:04:00','2018-03-18 00:05:00'",
        },
        {
          from:      Time.parse("2018-03-18 00:00:00", "%Y-%m-%d %H:%M:%S"),
          to:        Time.parse("2018-03-18 00:00:05", "%Y-%m-%d %H:%M:%S"),
          interval:  1.second,
          format:    "%Y-%m-%d %H:%M:%S",
          delimiter: ",",
          quote:     "'",
          expect:    "'2018-03-18 00:00:00','2018-03-18 00:00:01','2018-03-18 00:00:02','2018-03-18 00:00:03','2018-03-18 00:00:04','2018-03-18 00:00:05'",
        },
        {
          from:      Time.parse("2018-03-18 00:00:00", "%Y-%m-%d %H:%M:%S"),
          to:        Time.parse("2018-03-18 00:00:05", "%Y-%m-%d %H:%M:%S"),
          interval:  1.second,
          format:    "%H:%M:%S",
          delimiter: ",",
          quote:     "'",
          expect:    "'00:00:00','00:00:01','00:00:02','00:00:03','00:00:04','00:00:05'",
        },
        {
          from:      Time.parse("2018-03-18 00:00:00", "%Y-%m-%d %H:%M:%S"),
          to:        Time.parse("2018-03-18 00:00:03", "%Y-%m-%d %H:%M:%S"),
          interval:  1.second,
          format:    "%Y-%m-%d %H:%M:%S",
          delimiter: " | ",
          quote:     "'",
          expect:    "'2018-03-18 00:00:00' | '2018-03-18 00:00:01' | '2018-03-18 00:00:02' | '2018-03-18 00:00:03'",
        },
        {
          from:      Time.parse("2018-03-18 00:00:00", "%Y-%m-%d %H:%M:%S"),
          to:        Time.parse("2018-03-18 00:00:03", "%Y-%m-%d %H:%M:%S"),
          interval:  1.second,
          format:    "%Y-%m-%d %H:%M:%S",
          delimiter: " | ",
          quote:     "\"",
          expect:    "\"2018-03-18 00:00:00\" | \"2018-03-18 00:00:01\" | \"2018-03-18 00:00:02\" | \"2018-03-18 00:00:03\"",
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          Dast::Display.new(
            from: spec_case[:from],
            to: spec_case[:to],
            interval: spec_case[:interval],
            format: spec_case[:format],
            delimiter: spec_case[:delimiter],
            quote: spec_case[:quote]
          ).display.should eq spec_case[:expect]
        end
      end
    end
  end
end

require "../spec_helper"

describe Dast::DateList do
  describe "#to_s" do
    [
      {
        interval:  "1d",
        format:    "%Y-%m-%d %H:%M:%S",
        delimiter: ",",
        quote:     "'",
        arguments: ["2018-03-20", "2018-03-25"],
        expect:    "'2018-03-20 00:00:00','2018-03-21 00:00:00','2018-03-22 00:00:00','2018-03-23 00:00:00','2018-03-24 00:00:00','2018-03-25 00:00:00'",
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

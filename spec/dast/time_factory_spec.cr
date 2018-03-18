require "../spec_helper"

describe Dast::TimeFactory do
  describe "#create_time_from_and_to" do
    describe "returns Time object 'from' and 'to', " do
      [
        {
          arguments: ["2018-03-18", "2018-03-19"],
          expect:    {
            from: Time.parse("2018-03-18", "%F"),
            to: Time.parse("2018-03-19", "%F"),
          },
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          from, to = Dast::TimeFactory.new(arguments: spec_case[:arguments]).create_time_from_and_to
          from.should eq spec_case[:expect][:from]
          to.should eq spec_case[:expect][:to]
        end
      end
    end
  end
end

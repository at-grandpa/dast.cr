require "../../spec_helper"

describe Dast::PatternValues::DateTime do
  describe "#normalize" do
    describe "returns normalize date time str, " do
      [
        {
          input:  "2018-03-21",
          expect: "2018-03-21 00:00:00",
        },
        {
          input:  "2018-03-21 ",
          expect: "2018-03-21 00:00:00",
        },
        {
          input:  "2018/03/21",
          expect: "2018-03-21 00:00:00",
        },
        {
          input:  "2018/03/21 ",
          expect: "2018-03-21 00:00:00",
        },
        {
          input:  "2018-03-21 12:34:56",
          expect: "2018-03-21 12:34:56",
        },
        {
          input:  "2018/03/21 12:34:56",
          expect: "2018-03-21 12:34:56",
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          Dast::PatternValues::DateTime.new(input: spec_case[:input]).normalize.should eq spec_case[:expect]
        end
      end
    end
    describe "raises an UnitException, " do
      [
        {
          input:  "20180321",
        },
        {
          input:  "2018,03,21",
        },
        {
          input:  "2018-03-21  ",
        },
        {
          input:  "2018-03-21 00",
        },
        {
          input:  "2018-03-21 00:00",
        },
        {
          input:  "2018-03-21 00:00:0",
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          expect_raises(Dast::DastException, "Invalid time format. Please [%Y-%m-%d] or [%Y/%m/%d] or [%Y-%m-%d %H:%M:%S]") do
            Dast::PatternValues::DateTime.new(input: spec_case[:input]).normalize
          end
        end
      end
    end
  end
end

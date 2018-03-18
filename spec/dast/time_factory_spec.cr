require "../spec_helper"

describe Dast::TimeFactory do
  describe "#create_time_from_and_to" do
    describe "returns Time object 'from' and 'to', " do
      [
        {
          arguments: ["2018-03-18", "2018-03-19"],
          expect:    {
            from: Time.parse("2018-03-18", "%F"),
            to:   Time.parse("2018-03-19", "%F"),
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
    describe "raises an Exception, " do
      [
        {
          arguments: [] of String,
        },
        {
          arguments: ["2018-03-18", "2018-03-19", "2018-03-20"],
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          expect_raises(Exception, "Wrong number of arguments. (given #{spec_case[:arguments].size}, expected 2)") do
            Dast::TimeFactory.new(arguments: spec_case[:arguments]).create_time_from_and_to
          end
        end
      end
    end
  end
  describe "#format_for_time" do
    describe "returns string for Time.parse, " do
      [
        {
          input:  "2018-03-18",
          expect: "2018-03-18 00:00:00",
        },
        {
          input:  "2018/03/18",
          expect: "2018-03-18 00:00:00",
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          output = Dast::TimeFactory.new([] of String).format_for_time(spec_case[:input])
          output.should eq spec_case[:expect]
        end
      end
    end
    describe "raises an Exception, " do
      [
        {
          input: "20180318",
        },
        {
          input: "2018",
        },
        {
          input: "2018-03",
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          expect_raises(Exception, "Invalid time format. Please [%Y-%m-%d] or [%Y/%m/%d] or [%Y-%m-%d %H:%M:%S]") do
            Dast::TimeFactory.new([] of String).format_for_time(spec_case[:input])
          end
        end
      end
    end
  end
end

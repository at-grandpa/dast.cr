require "../spec_helper"

describe Dast::PatternValues::Span::Interval do
  describe "#value" do
    describe "returns Time::Span object, " do
      [
        {
          str:    "1year",
          expect: 1.year,
        },
        {
          str:    "2month",
          expect: 2.month,
        },
        {
          str:    "3day",
          expect: 3.day,
        },
        {
          str:    "4hour",
          expect: 4.hour,
        },
        {
          str:    "5minute",
          expect: 5.minute,
        },
        {
          str:    "6second",
          expect: 6.second,
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          Dast::PatternValues::Span::Interval.new(input: spec_case[:str]).to_time_span.should eq spec_case[:expect]
        end
      end
    end
    describe "raises an UnitException, " do
      [
        {
          str: "1.day",
        },
        {
          str: "1.foo",
        },
        {
          str: "1.bar",
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          expect_raises(Exception, "Invalid interval format. The format of the '--interval' is {Int}[year|y|month|mon|day|d|hour|h|minute|min|m|second|sec|s].") do
            Dast::PatternValues::Span::Interval.new(input: spec_case[:str]).to_time_span
          end
        end
      end
    end
    describe "raises an InvalidValueException, " do
      [
        {
          str: "1",
        },
        {
          str: "foo",
        },
        {
          str: "1.foo.bar",
        },
        {
          str: "1.1.foo",
        },
        {
          str: "1.1.foo",
        },
        {
          str: "1-1.foo",
        },
        {
          str: "foo.bar",
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          expect_raises(Exception, "Invalid interval format. The format of the '--interval' is {Int}[year|y|month|mon|day|d|hour|h|minute|min|m|second|sec|s].") do
            Dast::PatternValues::Span::Interval.new(input: spec_case[:str]).to_time_span
          end
        end
      end
    end
  end
end

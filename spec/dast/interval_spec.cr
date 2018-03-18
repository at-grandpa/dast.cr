require "../spec_helper"

describe Dast::Interval do
  describe "#value" do
    describe "returns Time::Span object, " do
      [
        {
          str:    "1.year",
          expect: 1.year,
        },
        {
          str:    "2.month",
          expect: 2.month,
        },
        {
          str:    "3.day",
          expect: 3.day,
        },
        {
          str:    "4.hour",
          expect: 4.hour,
        },
        {
          str:    "5.minute",
          expect: 5.minute,
        },
        {
          str:    "6.second",
          expect: 6.second,
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          Dast::Interval.new(str: spec_case[:str]).value.should eq spec_case[:expect]
        end
      end
    end
    describe "raises an UnitException, " do
      [
        {
          str:    "1.foo",
        },
        {
          str:    "1.bar",
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          expect_raises(Exception, "Only [year|month|day|hour|minute|second] is allowed for the interval unit. Not supported [#{spec_case[:str].split(".")[1]}].") do
            Dast::Interval.new(str: spec_case[:str]).value
          end
        end
      end
    end
    describe "raises an InvalidValueException, " do
      [
        {
          str:    "1",
        },
        {
          str:    "foo",
        },
        {
          str:    "1.foo.bar",
        },
        {
          str:    "1.1.foo",
        },
        {
          str:    "1.1.foo",
        },
        {
          str:    "1-1.foo",
        },
        {
          str:    "foo.bar",
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          expect_raises(Exception, "Invalid 'interval' argument. The syntax of the '--interval' is {Int}.[year|month|day|hour|minute|second].") do
            Dast::Interval.new(str: spec_case[:str]).value
          end
        end
      end
    end
  end
end

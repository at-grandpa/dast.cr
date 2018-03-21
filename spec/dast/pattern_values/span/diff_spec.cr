require "../../../spec_helper"

describe Dast::PatternValues::Span::Diff do
  describe "#to_time_span" do
    describe "returns Time::Span object, " do
      [
        {
          input:  "3",
          expect: 2.day,
        },
        {
          input:  "+3",
          expect: 2.day,
        },
        {
          input:  "~3",
          expect: -2.day,
        },
        {
          input:  "3year",
          expect: 2.year,
        },
        {
          input:  "+3year",
          expect: 2.year,
        },
        {
          input:  "~3year",
          expect: -2.year,
        },
        {
          input:  "3y",
          expect: 2.year,
        },
        {
          input:  "+3y",
          expect: 2.year,
        },
        {
          input:  "~3y",
          expect: -2.year,
        },
        {
          input:  "3month",
          expect: 2.month,
        },
        {
          input:  "+3month",
          expect: 2.month,
        },
        {
          input:  "~3month",
          expect: -2.month,
        },
        {
          input:  "3mon",
          expect: 2.month,
        },
        {
          input:  "+3mon",
          expect: 2.month,
        },
        {
          input:  "~3mon",
          expect: -2.month,
        },
        {
          input:  "3day",
          expect: 2.day,
        },
        {
          input:  "+3day",
          expect: 2.day,
        },
        {
          input:  "~3day",
          expect: -2.day,
        },
        {
          input:  "3d",
          expect: 2.day,
        },
        {
          input:  "+3d",
          expect: 2.day,
        },
        {
          input:  "~3d",
          expect: -2.day,
        },
        {
          input:  "3hour",
          expect: 2.hour,
        },
        {
          input:  "+3hour",
          expect: 2.hour,
        },
        {
          input:  "~3hour",
          expect: -2.hour,
        },
        {
          input:  "3h",
          expect: 2.hour,
        },
        {
          input:  "+3h",
          expect: 2.hour,
        },
        {
          input:  "~3h",
          expect: -2.hour,
        },
        {
          input:  "3minute",
          expect: 2.minute,
        },
        {
          input:  "+3minute",
          expect: 2.minute,
        },
        {
          input:  "~3minute",
          expect: -2.minute,
        },
        {
          input:  "3min",
          expect: 2.minute,
        },
        {
          input:  "+3min",
          expect: 2.minute,
        },
        {
          input:  "~3min",
          expect: -2.minute,
        },
        {
          input:  "3m",
          expect: 2.minute,
        },
        {
          input:  "+3m",
          expect: 2.minute,
        },
        {
          input:  "~3m",
          expect: -2.minute,
        },
        {
          input:  "3second",
          expect: 2.second,
        },
        {
          input:  "+3second",
          expect: 2.second,
        },
        {
          input:  "~3second",
          expect: -2.second,
        },
        {
          input:  "3sec",
          expect: 2.second,
        },
        {
          input:  "+3sec",
          expect: 2.second,
        },
        {
          input:  "~3sec",
          expect: -2.second,
        },
        {
          input:  "3s",
          expect: 2.second,
        },
        {
          input:  "+3s",
          expect: 2.second,
        },
        {
          input:  "~3s",
          expect: -2.second,
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          Dast::PatternValues::Span::Diff.new(input: spec_case[:input]).to_time_span.should eq spec_case[:expect]
        end
      end
    end
    describe "raises an UnitException, " do
      [
        {
          input: "-1",
        },
        {
          input: "1.day",
        },
        {
          input: "1.foo",
        },
        {
          input: "1.bar",
        },
        {
          input: "foo",
        },
        {
          input: "1.foo.bar",
        },
        {
          input: "1.1.foo",
        },
        {
          input: "1.1foo",
        },
        {
          input: "1-1.foo",
        },
        {
          input: "1-1foo",
        },
        {
          input: "1-1day",
        },
        {
          input: "foo.bar",
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          expect_raises(Dast::DastException, "Invalid diff format. Please /[+~]\d(year|y|month|mon|day|d||hour|h|minute|min|m|second|sec|s)?/") do
            Dast::PatternValues::Span::Diff.new(input: spec_case[:input]).to_time_span
          end
        end
      end
    end
  end
end

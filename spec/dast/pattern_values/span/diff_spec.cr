require "../../../spec_helper"

describe Dast::PatternValues::Span::Diff do
  describe "#to_time_span" do
    describe "returns Time::Span object, " do
      [
        {
          input:  "3",
          expect: 3.day,
        },
        {
          input:  "+3",
          expect: 3.day,
        },
        {
          input:  "~3",
          expect: -3.day,
        },
        {
          input:  "3year",
          expect: 3.year,
        },
        {
          input:  "+3year",
          expect: 3.year,
        },
        {
          input:  "~3year",
          expect: -3.year,
        },
        {
          input:  "3y",
          expect: 3.year,
        },
        {
          input:  "+3y",
          expect: 3.year,
        },
        {
          input:  "~3y",
          expect: -3.year,
        },
        {
          input:  "3month",
          expect: 3.month,
        },
        {
          input:  "+3month",
          expect: 3.month,
        },
        {
          input:  "~3month",
          expect: -3.month,
        },
        {
          input:  "3mon",
          expect: 3.month,
        },
        {
          input:  "+3mon",
          expect: 3.month,
        },
        {
          input:  "~3mon",
          expect: -3.month,
        },
        {
          input:  "3day",
          expect: 3.day,
        },
        {
          input:  "+3day",
          expect: 3.day,
        },
        {
          input:  "~3day",
          expect: -3.day,
        },
        {
          input:  "3d",
          expect: 3.day,
        },
        {
          input:  "+3d",
          expect: 3.day,
        },
        {
          input:  "~3d",
          expect: -3.day,
        },
        {
          input:  "3hour",
          expect: 3.hour,
        },
        {
          input:  "+3hour",
          expect: 3.hour,
        },
        {
          input:  "~3hour",
          expect: -3.hour,
        },
        {
          input:  "3h",
          expect: 3.hour,
        },
        {
          input:  "+3h",
          expect: 3.hour,
        },
        {
          input:  "~3h",
          expect: -3.hour,
        },
        {
          input:  "3minute",
          expect: 3.minute,
        },
        {
          input:  "+3minute",
          expect: 3.minute,
        },
        {
          input:  "~3minute",
          expect: -3.minute,
        },
        {
          input:  "3min",
          expect: 3.minute,
        },
        {
          input:  "+3min",
          expect: 3.minute,
        },
        {
          input:  "~3min",
          expect: -3.minute,
        },
        {
          input:  "3m",
          expect: 3.minute,
        },
        {
          input:  "+3m",
          expect: 3.minute,
        },
        {
          input:  "~3m",
          expect: -3.minute,
        },
        {
          input:  "3second",
          expect: 3.second,
        },
        {
          input:  "+3second",
          expect: 3.second,
        },
        {
          input:  "~3second",
          expect: -3.second,
        },
        {
          input:  "3sec",
          expect: 3.second,
        },
        {
          input:  "+3sec",
          expect: 3.second,
        },
        {
          input:  "~3sec",
          expect: -3.second,
        },
        {
          input:  "3s",
          expect: 3.second,
        },
        {
          input:  "+3s",
          expect: 3.second,
        },
        {
          input:  "~3s",
          expect: -3.second,
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
          expect_raises(Dast::DastException, "Invalid diff format. Please /(|+|~)\d(year|y|month|mon|day|d||hour|h|minute|min|m|second|sec|s)?/") do
            Dast::PatternValues::Span::Diff.new(input: spec_case[:input]).to_time_span
          end
        end
      end
    end
  end
end

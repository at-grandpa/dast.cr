require "../spec_helper"

describe Dast::TimeFactory do
  describe ".create_time_from_and_to" do
    describe "returns Time object 'from' and 'to', " do
      [
        {
          arguments: ["2018-03-18", "2018-03-19"],
          expect:    {
            from: Time.parse("2018-03-18", "%F"),
            to:   Time.parse("2018-03-19", "%F"),
          },
        },
        {
          arguments: ["2018-03-19", "2018-03-18"],
          expect:    {
            from: Time.parse("2018-03-18", "%F"),
            to:   Time.parse("2018-03-19", "%F"),
          },
        },
        {
          arguments: ["2018-03-19 00:00:00", "2018-03-18 12:00:00"],
          expect:    {
            from: Time.parse("2018-03-18 12:00:00", "%Y-%m-%d %H:%M:%S"),
            to:   Time.parse("2018-03-19 00:00:00", "%Y-%m-%d %H:%M:%S"),
          },
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          from, to = Dast::TimeFactory.create_time_from_and_to(arguments: spec_case[:arguments])
          from.should eq spec_case[:expect][:from]
          to.should eq spec_case[:expect][:to]
        end
      end
    end
    describe "raises an Exception, " do
      [
        {
          arguments: ["2018-03-18", "2018-03-19", "2018-03-20"],
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          expect_raises(Exception, "Wrong number of arguments. (given #{spec_case[:arguments].size}, expected 0 or 1 or 2)") do
            Dast::TimeFactory.create_time_from_and_to(arguments: spec_case[:arguments])
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
        {
          input:  "2018-03-18 12:34:56",
          expect: "2018-03-18 12:34:56",
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          output = Dast::TimeFactory.format_for_time(spec_case[:input])
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
        {
          input: "2018-03-18 12:34",
        },
        {
          input: "2018/03/18 12:34",
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          expect_raises(Exception, "Invalid time format. Please [%Y-%m-%d] or [%Y/%m/%d] or [%Y-%m-%d %H:%M:%S]") do
            Dast::TimeFactory.format_for_time(spec_case[:input])
          end
        end
      end
    end
  end
  describe "#split_diff" do
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
        input:  "-3",
        expect: -3.day,
      },
      {
        input:  "+3year",
        expect: 3.year,
      },
      {
        input:  "+3y",
        expect: 3.year,
      },
      {
        input:  "+3month",
        expect: 3.month,
      },
      {
        input:  "+3mon",
        expect: 3.month,
      },
      {
        input:  "+3day",
        expect: 3.day,
      },
      {
        input:  "+3d",
        expect: 3.day,
      },
      {
        input:  "+3hour",
        expect: 3.hour,
      },
      {
        input:  "+3h",
        expect: 3.hour,
      },
      {
        input:  "+3minute",
        expect: 3.minute,
      },
      {
        input:  "+3min",
        expect: 3.minute,
      },
      {
        input:  "+3m",
        expect: 3.minute,
      },
      {
        input:  "+3second",
        expect: 3.second,
      },
      {
        input:  "+3sec",
        expect: 3.second,
      },
      {
        input:  "+3s",
        expect: 3.second,
      },
      {
        input:  "+10",
        expect: 10.day,
      },
      {
        input:  "-10",
        expect: -10.day,
      },
    ].each do |spec_case|
      describe "returns #{spec_case[:expect]}, " do
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          match = Dast::TimeFactory.split_diff(spec_case[:input])
          match.should eq spec_case[:expect]
        end
      end
    end
    [
      {
        input: "foo",
      },
      {
        input: "+3dayfoo",
      },
      {
        input: "+3day foo",
      },
      {
        input: "+3.day",
      },
    ].each do |spec_case|
      describe "raises an Exception, " do
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          expect_raises(Exception, "Invalid diff format. Please /[+\-]\d(year|month|day|hour|minute|second)?/") do
            Dast::TimeFactory.split_diff(spec_case[:input])
          end
        end
      end
    end
  end
  describe "#calc_diff" do
    [
      {
        time:   Time.parse("2018-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
        diff:   "3",
        expect: Time.parse("2018-03-23 00:00:00", "%Y-%m-%d %H:%M:%S"),
      },
      {
        time:   Time.parse("2018-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
        diff:   "+3",
        expect: Time.parse("2018-03-23 00:00:00", "%Y-%m-%d %H:%M:%S"),
      },
      {
        time:   Time.parse("2018-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
        diff:   "+3y",
        expect: Time.parse("2021-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
      },
      {
        time:   Time.parse("2018-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
        diff:   "-3m",
        expect: Time.parse("2018-03-19 23:57:00", "%Y-%m-%d %H:%M:%S"),
      },
      {
        time:   Time.parse("2018-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
        diff:   "-3h",
        expect: Time.parse("2018-03-19 21:00:00", "%Y-%m-%d %H:%M:%S"),
      },
    ].each do |spec_case|
      describe "returns #{spec_case[:expect]}, " do
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          Dast::TimeFactory.calc_diff(spec_case[:time], spec_case[:diff]).should eq spec_case[:expect]
        end
      end
    end
  end
end

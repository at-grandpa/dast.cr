require "../spec_helper"

describe Dast::TimeFactory do
  describe ".create_times" do
    describe "returns Time object 'from' and 'to', " do
      [
        {
          now:       Time.parse("2018-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
          arguments: ["2018-03-18", "2018-03-19"],
          expect:    {
            from: Time.parse("2018-03-18", "%F"),
            to:   Time.parse("2018-03-19", "%F"),
          },
        },
        {
          now:       Time.parse("2018-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
          arguments: ["2018-03-19", "2018-03-18"],
          expect:    {
            from: Time.parse("2018-03-18", "%F"),
            to:   Time.parse("2018-03-19", "%F"),
          },
        },
        {
          now:       Time.parse("2018-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
          arguments: ["2018-03-19 00:00:00", "2018-03-18 12:00:00"],
          expect:    {
            from: Time.parse("2018-03-18 12:00:00", "%Y-%m-%d %H:%M:%S"),
            to:   Time.parse("2018-03-19 00:00:00", "%Y-%m-%d %H:%M:%S"),
          },
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          from, to = Dast::TimeFactory.create_times(spec_case[:now], spec_case[:arguments])
          from.should eq spec_case[:expect][:from]
          to.should eq spec_case[:expect][:to]
        end
      end
    end
    describe "raises an Exception, " do
      [
        {
          now:       Time.parse("2018-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
          arguments: ["2018-03-18", "2018-03-19", "2018-03-20"],
        },
      ].each do |spec_case|
        it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
          expect_raises(Exception, "Wrong number of arguments. (given #{spec_case[:arguments].size}, expected 0 or 1 or 2)") do
            Dast::TimeFactory.create_times(spec_case[:now], spec_case[:arguments])
          end
        end
      end
    end
  end
  describe "#normalize_date_time" do
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
          output = Dast::TimeFactory.normalize_date_time(spec_case[:input])
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
            Dast::TimeFactory.normalize_date_time(spec_case[:input])
          end
        end
      end
    end
  end
  # describe "#split_diff" do
  #  [
  #    {
  #      input:  "3",
  #      expect: 2.day,
  #    },
  #    {
  #      input:  "+3",
  #      expect: 2.day,
  #    },
  #    {
  #      input:  "~3",
  #      expect: -2.day,
  #    },
  #    {
  #      input:  "+3year",
  #      expect: 2.year,
  #    },
  #    {
  #      input:  "+3y",
  #      expect: 2.year,
  #    },
  #    {
  #      input:  "+3month",
  #      expect: 2.month,
  #    },
  #    {
  #      input:  "+3mon",
  #      expect: 2.month,
  #    },
  #    {
  #      input:  "+3day",
  #      expect: 2.day,
  #    },
  #    {
  #      input:  "+3d",
  #      expect: 2.day,
  #    },
  #    {
  #      input:  "+3hour",
  #      expect: 2.hour,
  #    },
  #    {
  #      input:  "+3h",
  #      expect: 2.hour,
  #    },
  #    {
  #      input:  "+3minute",
  #      expect: 2.minute,
  #    },
  #    {
  #      input:  "+3min",
  #      expect: 2.minute,
  #    },
  #    {
  #      input:  "+3m",
  #      expect: 2.minute,
  #    },
  #    {
  #      input:  "+3second",
  #      expect: 2.second,
  #    },
  #    {
  #      input:  "+3sec",
  #      expect: 2.second,
  #    },
  #    {
  #      input:  "+3s",
  #      expect: 2.second,
  #    },
  #    {
  #      input:  "+10",
  #      expect: 9.day,
  #    },
  #    {
  #      input:  "~10",
  #      expect: -9.day,
  #    },
  #  ].each do |spec_case|
  #    describe "returns #{spec_case[:expect]}, " do
  #      it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
  #        match = Dast::TimeFactory.split_diff(spec_case[:input])
  #        match.should eq spec_case[:expect]
  #      end
  #    end
  #  end
  #  [
  #    {
  #      input: "foo",
  #    },
  #    {
  #      input: "+3dayfoo",
  #    },
  #    {
  #      input: "+3day foo",
  #    },
  #    {
  #      input: "+3.day",
  #    },
  #  ].each do |spec_case|
  #    describe "raises an Exception, " do
  #      it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
  #        expect_raises(Exception, "Invalid diff format. Please /[+\-]\d(year|month|day|hour|minute|second)?/") do
  #          Dast::TimeFactory.split_diff(spec_case[:input])
  #        end
  #      end
  #    end
  #  end
  # end
  # describe "#calc_diff" do
  #  [
  #    {
  #      time:   Time.parse("2018-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
  #      diff:   "3",
  #      expect: Time.parse("2018-03-22 00:00:00", "%Y-%m-%d %H:%M:%S"),
  #    },
  #    {
  #      time:   Time.parse("2018-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
  #      diff:   "+3",
  #      expect: Time.parse("2018-03-22 00:00:00", "%Y-%m-%d %H:%M:%S"),
  #    },
  #    {
  #      time:   Time.parse("2018-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
  #      diff:   "+3y",
  #      expect: Time.parse("2020-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
  #    },
  #    {
  #      time:   Time.parse("2018-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
  #      diff:   "~3m",
  #      expect: Time.parse("2018-03-19 23:58:00", "%Y-%m-%d %H:%M:%S"),
  #    },
  #    {
  #      time:   Time.parse("2018-03-20 00:00:00", "%Y-%m-%d %H:%M:%S"),
  #      diff:   "~3h",
  #      expect: Time.parse("2018-03-19 22:00:00", "%Y-%m-%d %H:%M:%S"),
  #    },
  #  ].each do |spec_case|
  #    describe "returns #{spec_case[:expect]}, " do
  #      it "when #{spec_case.to_h.reject { |k, _| k.to_s == "expect" }}" do
  #        Dast::TimeFactory.calc_diff(spec_case[:time], spec_case[:diff]).should eq spec_case[:expect]
  #      end
  #    end
  #  end
  # end
end

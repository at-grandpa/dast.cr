require "./span/*"

module Dast
  class DateList
    def initialize(
      @now : Time,
      @interval : String,
      @format : String,
      @delimiter : String,
      @quote : String,
      @arguments : Array(String)
    )
    end

    def to_s
      from, to = Dast::TimeFactory.create_times(@now, @arguments)
      interval = Dast::Span::Interval.new(@interval).to_time_span
      from.range(to, interval).to_a.map { |time| @quote + time.to_s(@format) + @quote }.join(@delimiter)
    end
  end
end

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
      from, to = Dast::TimeFactory.create_time_from_and_to(@now, @arguments)
      Dast::Display.new(
        from: from,
        to: to,
        interval: Dast::Span::Interval.new(@interval).to_time_span,
        format: @format,
        delimiter: @delimiter,
        quote: @quote
      ).display
    end
  end
end

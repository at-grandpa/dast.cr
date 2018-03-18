module Dast
  class Display
    def initialize(
      @from : Time,
      @to : Time,
      @interval : Time::MonthSpan | Time::Span,
      @format : String,
      @delimiter : String,
      @quote : String
    )
    end

    def display
      @from.range(@to, @interval).to_a.map { |time| @quote + time.to_s(@format) + @quote }.join(@delimiter)
    end
  end
end

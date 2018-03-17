module Dast
  class Display
    def initialize(
      @from : Time,
      @to : Time,
      @interval : Time::Span,
      @format : String,
      @delimiter : String,
      @quote : String
    )
    end

    def display
      @from.interval = @interval
      (@from..@to).to_a.map { |time| @quote + time.to_s(@format) + @quote }.join(@delimiter)
    end
  end
end

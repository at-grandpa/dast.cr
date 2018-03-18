module Dast
  class TimeFactory
    def initialize(@arguments : Array(String))
    end

    def create_time_from_and_to
      return Time.parse("2018-03-18", "%F"), Time.parse("2018-03-19", "%F")
    end
  end
end

module Dast
  class TimeFactory
    def initialize(@arguments : Array(String))
    end

    def create_time_from_and_to
      raise Exception.new("Wrong number of arguments. (given #{@arguments.size}, expected 2)") unless @arguments.size == 2
      return Time.parse("2018-03-18", "%F"), Time.parse("2018-03-19", "%F")
    end

    def format_for_time(input)
      input
    end
  end
end

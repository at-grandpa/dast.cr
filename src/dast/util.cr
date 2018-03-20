require "./span/*"

module Dast
  module Util
    def self.match_values(input : String | Nil, pattern : Regex, keys : Array(String), exception : Exception) : Array(String)
      raise exception if input.nil?
      match = input.match(pattern)
      raise exception if match.nil?
      ret = [] of String
      keys.each do |key|
        value = match.to_h[key]?
        raise exception if value.nil?
        ret << value
      end
      return ret
    end
  end
end

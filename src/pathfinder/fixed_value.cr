require "./die"

module Pathfinder
  # Allows to create a Fixed value, which will only gives it everytime.
  # (min, max, test, average)
  module FixedValue
    # Returns a `Die` with only one face.
    def self.new(value : Int32)
      Pathfinder::Die.new(value..value)
    end
  end
end

require "./is_rollable"

module Rollable
  # A `Die` is a range of Integer values.
  # It is rollable.
  #
  # Example:
  # ```
  # d = Die.new(1..6)
  # d.min     # => 1
  # d.max     # => 6
  # d.average # => 3.5
  # d.test    # => a random value included in 1..6
  # ```
  class Die < IsRollable
    @faces : Range(Int32, Int32)

    def initialize(@faces)
    end

    def initialize(nb_faces : Int32)
      @faces = 1..nb_faces
    end

    # Reverse the values
    #
    # Example:
    # ```
    # Die.new(1..6).reverse # => Die.new -6..-1
    # ```
    def reverse : Die
      Die.new -max..-min
    end

    def max : Int32
      @faces.end
    end

    def min : Int32
      @faces.begin
    end

    # Return a random value in the range of the dice
    def test : Int32
      @faces.to_a.sample
    end

    # Mathematical expectation.
    #
    # A d6 will have a expected value of 3.5
    def average : Float64
      @faces.reduce { |r, l| r + l }.to_f64 / @faces.size
    end

    # Number of faces of the `Die`
    def size
      @faces.size
    end

    # Return a string.
    # - It may be a fixed value ```(n..n) => "#{n}"```
    # - It may be a dice ```(1..n) => "D#{n}"```
    # - Else, ```(a..b) => "D(#{a},#{b})"```
    def to_s : String
      if self.size == 1
        min.to_s
      elsif self.min == 1
        "D#{self.max}"
      else
        "D(#{self.min},#{self.max})"
      end
    end
  end
end

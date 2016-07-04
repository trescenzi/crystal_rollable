module Pathfinder
  abstract class Rollable
    abstract def min : Int32
    abstract def max : Int32
    abstract def average : Int32
    abstract def test : Int32
  end
end

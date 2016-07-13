module Rollable
  class Roll
    # Parse the string and return an array of `Dice`
    #
    # see `Dice.consume`
    #
    # The string passed as parameter is consumed, part by part, to create an
    # Array of `Dice`. The string must follow grammar below (case insensitive):
    # ```text
    # - dice = [\d+][d][\d+]
    # - sign = ['+', '-']
    # - sdice = [sign]?[dice]
    # - roll = [sign][dice][sdice]*
    # ```
    def self.parse_str(str : String?, list : Array(Dice) = Array(Dice).new) : Array(Dice)
      return list if str.nil?
      str = str.strip
      sign = str[0]
      if sign != '+' && sign != '-' && !list.empty?
        raise ParsingError.new("Parsing Error: roll, near to '#{str}'")
      end
      str = str[1..-1] if sign == '-' || sign == '+'
      rest = Dice.consume(str) do |dice|
        list << (sign == '-' ? dice.reverse : dice)
      end
      parse_str(rest, list)
      return list
    end

    # Parse the string "str" and returns a new `Roll` object
    # see `#parse_str`
    def self.parse(str : String) : Roll
      return Roll.new(parse_str(str))
    end

    def to_s : String
      @dice.reduce(nil) do |l, r|
        if l
          if r.min < 0 && r.max < 0
            l + " - " + r.reverse.to_s
          else
            l + " + " + r.to_s
          end
        else
          r.to_s
        end
      end.to_s
    end
  end
end

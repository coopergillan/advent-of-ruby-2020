class Solver
  attr_accessor :signal_combos

  def initialize(signal_combos)
    @signal_combos = signal_combos
  end

  def self.from_file(filepath)
    combos = File.foreach(filepath).map { |line| SignalCombo.from_raw(line) }
    new(combos)
  end

  def part1
    @signal_combos.map { |combo| combo.unique_chars_count }.reduce(:+)
  end

  def part2
    @signal_combos.map { |combo| combo.output_to_number }.reduce(:+)
  end
end

class SignalCombo
  attr_accessor :signal_patterns, :output_values, :numbers_hash

  FIXED_SIGNAL_LENGTHS = {
    2 => 1,
    3 => 7,
    4 => 4,
    7 => 8,
  }
  def initialize(signal_patterns, output_values)
    @signal_patterns = signal_patterns
    @output_values = output_values
    @numbers_hash = {}
  end

  def self.from_raw(raw_input)
    raw_signal_patterns, raw_output_values = raw_input.split("|")

    signal_patterns = raw_signal_patterns.split
    output_values = raw_output_values.split
    new(signal_patterns, output_values)
  end

  def arrayify(chars)
    # Turn chars into an array for array arithmetic
    chars.each_char.to_a
  end

  def char_intersection_size(chars, chars_to_compare)
    arrayify(chars).intersection(arrayify(chars_to_compare)).size
  end

  def build_hash
    digit_to_chars = {}
    sorted_signals = @signal_patterns.sort_by(&:length)

    # The largest chars set must be 8 - sort the chars to make later reference easier
    digit_to_chars[8] = sorted_signals.pop

    # The first three are those known
    [1, 7, 4].each do |known|
      digit_to_chars[known] = sorted_signals.shift
    end

    # Pull some known numbers out for comparing later
    one, four, eight = digit_to_chars.values_at(1, 4, 8)

    # Pull six-character chars out
    sixes = sorted_signals.pop(3)
    sixes.cycle do |chars|

      # Find 9 - it's the only six-character one that has all of four's characters
      if char_intersection_size(chars, four) == four.size
        digit_to_chars[9] = sixes.delete(chars)
      end

      # Find 6 - does not share all of 1 so the intersection will only have one char
      if char_intersection_size(chars, one) != one.size
        digit_to_chars[6] = sixes.delete(chars)
      end

      # 0 can be added when it is the only one left over
      digit_to_chars[0] = sixes.pop if sixes.one?
    end

    # Now pull the fives out and do more elimination
    fives = sorted_signals.pop(3)
    fives.cycle do |chars|

      # Find 3 - the only five-digit char that has both of 1's chars
      if char_intersection_size(chars, one) == one.size
        digit_to_chars[3] = fives.delete(chars)
      end

      # Now find 2 - it should contain all of the difference between 8 and four (while five does not)
      eight_minus_four_chars = (arrayify(eight) - arrayify(four)).join
      if char_intersection_size(chars, eight_minus_four_chars) == eight_minus_four_chars.size
        digit_to_chars[2] = fives.delete(chars)
      end

      # 5 is the only one left now
      digit_to_chars[5] = fives.pop if fives.one?
    end

    # Now flip the hash in order to decode the output values
    @numbers_hash = digit_to_chars.invert
  end

  def output_to_number
    build_hash

    sorted_key_numbers_hash = {}.tap do |hash|
      @numbers_hash.each do |chars, digit|
        hash[chars.each_char.sort.join] = digit
      end
    end

    @output_values.reduce("") do |num_string, val|
      sorted_val = val.each_char.sort.join
      num_string += sorted_key_numbers_hash[sorted_val].to_s
    end.to_i
  end

  def unique_chars_count
    @output_values.map { |char| (FIXED_SIGNAL_LENGTHS.keys.include?(char.size) ? 1 : 0) }.reduce(:+)
  end
end

if $PROGRAM_NAME  == __FILE__
  solver = Solver.from_file("lib/input.txt")

  puts "Answer for part 1: #{solver.part1}"
  puts "Answer for part 2: #{solver.part2}"
end

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
end

class DigitSignal
  attr_accessor :chars

  FIXED_SIGNAL_LENGTHS = {
    2 => 1,
    3 => 7,
    4 => 4,
    # 5 => [2, 3, 5],
    # 6 => [0, 6, 9],
    7 => 8,
  }

  def initialize(chars)
    @chars = chars
  end

  def chars_length
    @chars.size
  end

  def shares(other_digit_signal)
    # Which characters are shared between two
    @chars.each_char.to_i & other_digit_signal.chars.each_char.to_a
  end

  def decode
    FIXED_SIGNAL_LENGTHS[chars_length]
  end
end

class SignalCombo
  attr_accessor :signal_patterns, :output_values, :numbers_hash

  FIXED_SIGNAL_LENGTHS = {
    2 => 1,
    3 => 7,
    4 => 4,
    # 5 => [2, 3, 5],
    # 6 => [0, 6, 9],
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

  def sort_chars(chars)
    # require "pry"; binding.pry
    chars.each_char.to_a.sort.join
  end

  def arrayify(chars)
    # Turn chars into an array for array arithmetic
    chars.each_char.to_a
  end

  def build_hash
    @signal_patterns.each do |pattern|

      # Populate the four fixed lengths for use in the rest, then come back through =|
      if fixed_length = FIXED_SIGNAL_LENGTHS[pattern.size]
        @numbers_hash[pattern] = fixed_length
      end
    end

    @signal_patterns.each do |pattern|
      # Find six character ones
      if pattern.size == 6
        # Find the number six - should be missing a character that does not contain both chars from 1
        if !sort_chars(pattern).include?(sort_chars(@numbers_hash.invert[1]))
          @numbers_hash[pattern] = pattern.size
        # Find zero - only diff between it and 8 should be one character in 4
        elsif middle_section = (arrayify(@numbers_hash.invert[8]) - arrayify(pattern)).join
          # require "pry"; binding.pry
          @numbers_hash.invert[4].include?(middle_section)
          @numbers_hash[pattern] = 0
        end
      end
    end
  end

  def unique_chars_count
    # unique_chars = [2, 3, 4, 7]
    @output_values.map { |char| (FIXED_SIGNAL_LENGTHS.keys.include?(char.size) ? 1 : 0) }.reduce(:+)
  end
end

if $PROGRAM_NAME  == __FILE__
  solver = Solver.from_file("lib/input.txt")
  puts "Answer for part 1: #{solver.part1}"

  # school2 = School.from_file("lib/input.txt")
  # part2_answer = school2.part2
  # puts "Answer for part 2: #{part2_answer}"
end

# DIGIT_PARTS = [
#   :top,
#   :top_left,
#   :top_right,
#   :middle,
#   :bottom_left,
#   :bottom_right,
#   :bottom,
# ]

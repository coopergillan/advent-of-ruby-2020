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
    thesum = 0
    @signal_combos.each do |combo|
      puts "Checking combo: #{combo}"
      combo.build_hash
      output_number = combo.output_to_number
      # puts "Got output_number: #{output_number}"
    #   output_number
    end
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
    chars.each_char.to_a.sort.join
  end

  def arrayify(chars)
    # Turn chars into an array for array arithmetic
    chars.each_char.to_a
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

    # Pull six-character chars out
    sixes = sorted_signals.pop(3)
    cycle_count = 0
    sixes.cycle do |chars|
      # puts "Checking sixes with size: #{sixes.size}"
      # puts "chars: #{chars}"
      # puts "sixes: #{sixes}"

      # Find number 6 - does not share all of 1
      if !sort_chars(chars).include?(sort_chars(digit_to_chars[1]))
        # puts "Found 6, right? #{chars}"
        digit_to_chars[6] = sixes.delete(chars)
      end

      # Find 9 - it's the only six-character one that has all of four's characters
      char_to_four_intersection = arrayify(chars).intersection(arrayify(digit_to_chars[4]))
      # All of the characters match to four
      if char_to_four_intersection.size == digit_to_chars[4].size
        digit_to_chars[9] = sixes.delete(chars)
      end
      # sorted_nine = sort_chars(chars)
      # puts "Got sorted nine: #{sorted_nine}"
      # sorted_four = sort_chars(digit_to_chars[4])
      # puts "Got sorted four: #{sorted_four}"
      # if arrayify(chars).include?(sort_chars(digit_to_chars[4]))
      #   puts "Found 9, right? #{chars}"
      #   digit_to_chars[9] = sixes.delete(chars)
      # end
      cycle_count += 1
      # puts "Finished checking #{chars}"
      # puts "Finished the cycle! Run number #{cycle_count}"
      # puts "digit_to_chars: #{digit_to_chars}"
      # puts "============================="
      digit_to_chars[0] = sixes.pop if sixes.one?
    end

    # Now pull the fives out and do more elimination
    fives = sorted_signals.pop(3)

    fives.cycle do |chars|
      # Now find 2 - it should contain all of the difference between 8 and four (while five does not)
      eight_to_four_diff = arrayify(digit_to_chars[8]) - arrayify(digit_to_chars[4])
      # puts "eight_to_four_diff: #{eight_to_four_diff}"
      if arrayify(chars).intersection(eight_to_four_diff).size == eight_to_four_diff.size
        digit_to_chars[2] = fives.delete(chars)
      end

      # Find the number 3 - it's the only five-digit that has both of 1's chars
      char_to_one = arrayify(chars).intersection(arrayify(digit_to_chars[1]))
      # puts "char_to_one: #{char_to_one}"
      # puts "digit_to_chars: #{digit_to_chars}"
      if char_to_one.size == digit_to_chars[1].size
        digit_to_chars[3] = fives.delete(chars)
      end

      # 5 is left over
      if fives.one?
        digit_to_chars[5] = fives.pop
      end
    end

    puts "finished mapping the chars - digit_to_chars: #{digit_to_chars}"
    @numbers_hash = digit_to_chars.invert
    raise if @numbers_hash.size != 10
  end

  def output_to_number
    puts "Checking @numbers_hash: #{@numbers_hash}"
    sorted_key_numbers_hash = {}.tap do |hash|
      @numbers_hash.each do |chars, digit|
        puts "chars: #{chars}"
        puts "digit: #{digit}"
        puts "=================="
        hash[chars.each_char.sort.join] = digit
      end
    end
    output_string = @output_values.reduce("") do |num, val|
      sorted_val = val.each_char.sort.join
      num += sorted_key_numbers_hash[sorted_val].to_s
    end
    output_string.to_i
  end

  def unique_chars_count
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

# class DigitSignal
#   attr_accessor :chars
#
#   FIXED_SIGNAL_LENGTHS = {
#     2 => 1,
#     3 => 7,
#     4 => 4,
#     # 5 => [2, 3, 5],
#     # 6 => [0, 6, 9],
#     7 => 8,
#   }
#
#   def initialize(chars)
#     @chars = chars
#   end
#
#   def chars_length
#     @chars.size
#   end
#
#   def shares(other_digit_signal)
#     # Which characters are shared between two
#     @chars.each_char.to_i & other_digit_signal.chars.each_char.to_a
#   end
#
#   def decode
#     FIXED_SIGNAL_LENGTHS[chars_length]
#   end
# end


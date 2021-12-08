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

class SignalCombo
  attr_accessor :chars

  def initialize(chars)
    @chars = chars
  end

  def char_count
    @chars.size
  end

  def unique_chars_count
    unique_chars = [2, 3, 4, 7]
    @chars.map { |char| (unique_chars.include?(char.size) ? 1 : 0) }.reduce(:+)
  end

  def self.from_raw(raw_input)
    new(raw_input.split("|").last.split)
  end

end

if $PROGRAM_NAME  == __FILE__
  solver = Solver.from_file("lib/input.txt")
  puts "Answer for part 1: #{solver.part1}"

  # school2 = School.from_file("lib/input.txt")
  # part2_answer = school2.part2
  # puts "Answer for part 2: #{part2_answer}"
end

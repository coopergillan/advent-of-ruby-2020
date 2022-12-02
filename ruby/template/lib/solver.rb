class TopLevelClass

  attr_accessor :input_data

  def initialize(input_data)
    @input_data = input_data
  end

  def self.from_file(filepath)
    ###
    # For reading each line into an array
    # raw_content = File.foreach(filepath, chomp: true).map { |line| line.split(/ /) }

    # For processing that content, for example to an integer
    # processed_content = raw_content.map { |line| line.map(:&to_i) }

    ###
    # For reading input with line breaks that distinguish separate objects
    # raw_content = File.read(filepath, chomp: true).split(/\n\n/)

    # For processing each line within the separate objects, for example, getting the integer of each line
    # processed_content = raw_content.map { |line| line.split(/\n/).map(&:to_i) }

    # Delete this placeholder processed content before using
    processed_content = [[4, 7], [3, 3], [2, 9]]

    # Instantiate the top-level class with processed data
    new(processed_content)
  end

  def solve_part1
    5
  end

  def solve_part2
    8
  end
end

class ParticularClass

  attr_accessor :input1, :input2

  def initialize(input1, input2)
    @input1 = input1
    @input2 = input2
  end

  def self.from_raw(raw_input)
    raw_input1, raw_input2 = raw_input
    new(raw_input1, raw_input2)
  end
end

if $PROGRAM_NAME  == __FILE__
  top_level_instance = TopLevelClass.from_file("lib/input.txt")

  part1 = top_level_instance.solve_part1
  puts "Part one answer: #{part1}"

  part2 = top_level_instance.solve_part2
  puts "Part two answer: #{part2}"
end

class CathodeRayTube

  attr_accessor :instructions

  def initialize(instructions)
    @instructions = instructions
  end

  def self.from_file(filepath)
    content = File.foreach(filepath, chomp: true).map do |line|
      line.split(/ /).map { |val| case val.to_i when 0 then val else val.to_i end }
    end

    new(content)
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

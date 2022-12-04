class Assignments

  attr_accessor :input_data

  def initialize(input_data)
    @input_data = input_data
  end

  def self.from_file(filepath)
    processed_content = File.foreach(filepath, chomp: true).map do |line|
      line.split(/[,-]/).map(&:to_i)
    end

    new(processed_content)
  end

  def solve_part1
    overlaps = 0
    input_data.each do |assignment|
      if (assignment[0] >= assignment[2] && assignment[1] <= assignment[3]) ||
          (assignment[2] >= assignment[0] && assignment[3] <= assignment[1])
        overlaps += 1
      end
    end
    overlaps
  end

  def solve_part2
    overlaps = 0
    input_data.each do |assignment|
      if ((assignment[1] >= assignment[2] && assignment[3] >= assignment[0]) ||
        (assignment[3] >= assignment[0] && assignment[1] >= assignment[2]))
        overlaps += 1
      end
    end
    overlaps
  end
end

if $PROGRAM_NAME  == __FILE__
  assignments = Assignments.from_file("lib/input.txt")

  part1 = assignments.solve_part1
  puts "Part one answer: #{part1}"

  part2 = assignments.solve_part2
  puts "Part two answer: #{part2}"
end

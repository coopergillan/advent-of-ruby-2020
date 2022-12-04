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
    8
  end
end

# class ParticularClass
#
#   attr_accessor :input1, :input2
#
#   def initialize(input1, input2)
#     @input1 = input1
#     @input2 = input2
#   end
#
#   def self.from_raw(raw_input)
#     raw_input1, raw_input2 = raw_input
#     new(raw_input1, raw_input2)
#   end
# end

if $PROGRAM_NAME  == __FILE__
  assignments = Assignments.from_file("lib/input.txt")

  part1 = assignments.solve_part1
  puts "Part one answer: #{part1}"

  # part2 = top_level_instance.solve_part2
  # puts "Part two answer: #{part2}"
end

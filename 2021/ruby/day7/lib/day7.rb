class CrabSchool
  attr_accessor :positions

  def initialize(positions)
    @positions = positions
  end

  def self.from_file(filepath)
    positions = File.read(filepath, chomp: true).split(",").map(&:to_i)
    new(positions)
  end

  def calculate_fuel(final_position)
    @positions.reduce(0) do |fuel, position|
      fuel + (position - final_position).abs
    end
  end

  def part1
    calculate_fuel(mean_position)
  end

  def part2
  end

  private

  def mean_position
    @positions.sort[@positions.size / 2]
  end

end


if $PROGRAM_NAME  == __FILE__
  school1 = CrabSchool.from_file("lib/input.txt")
  part1_answer = school1.part1
  puts "Answer for part 1: #{part1_answer}"
end

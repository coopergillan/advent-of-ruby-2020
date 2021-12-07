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

  def calculate_new_fuel(final_position)
    @positions.reduce(0) do |fuel, position|
      fuel + fuel_for_move(position, final_position)
    end
  end

  def fuel_for_move(start_position, end_position)
    moves = (end_position - start_position).abs
    (0..moves).reduce(:+)
  end

  def part1
    calculate_fuel(median_position)
  end

  def part2
    position_to_use = mean_position
    start = mean_position - 10
    final = mean_position + 10
    results = []
    (start..final).each do |final_position|
      results << calculate_new_fuel(final_position)
    end
    results.min
    # puts "Got mean_position: #{mean_position}"
		# calculate_new_fuel(mean_position)
  end

  private

  def mean_position
    (@positions.reduce(:+) / @positions.size.to_f).round
  end

  def median_position
    @positions.sort[@positions.size / 2]
  end

end


if $PROGRAM_NAME  == __FILE__
  school1 = CrabSchool.from_file("lib/input.txt")
  part1_answer = school1.part1
  puts "Answer for part 1: #{part1_answer}"

  school2 = CrabSchool.from_file("lib/input.txt")
  part2_answer = school2.part2
  puts "Answer for part 2: #{part2_answer}"
end

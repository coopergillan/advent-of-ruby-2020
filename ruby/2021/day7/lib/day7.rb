class CrabSchool
  attr_accessor :positions

  def initialize(positions)
    @positions = positions
  end

  def self.from_file(filepath)
    positions = File.read(filepath, chomp: true).split(",").map(&:to_i)
    new(positions)
  end

  def fuel_for_move(start_position, end_position)
    moves = (end_position - start_position).abs
    (0..moves).reduce(:+)
  end

  def part1
    calculate_fuel(median_position)
  end

  def part2
    mean_positions.map { |p| calculate_new_fuel(p) }.min
  end

  private

  def calculate_fuel(final_position)
    @positions.reduce(0) do |fuel, position|
      fuel + (position - final_position).abs
    end
  end

  def median_position
    @positions.sort[@positions.size / 2]
  end

  def calculate_new_fuel(final_position)
    @positions.reduce(0) do |fuel, position|
      fuel + fuel_for_move(position, final_position)
    end
  end

  def mean_positions
    raw_mean = (@positions.reduce(:+) / @positions.size.to_f)

    [raw_mean.floor, raw_mean.round]
  end

end


if $PROGRAM_NAME  == __FILE__
  crab_school = CrabSchool.from_file("lib/input.txt")

  puts "Answer for part 1: #{crab_school.part1}"
  puts "Answer for part 2: #{crab_school.part2}"
end

class School
  attr_accessor :population

  def initialize(population)
    @population = population_to_hash(population)
  end

  def self.from_file(filepath)
    fish_array = File.read(filepath, chomp: true).split(",").map(&:to_i)
    new(fish_array)
  end

  def simulate_day
    start_population = @population.clone

    @population.size.times.reverse_each do |key|
      new_count_key = key - 1
      count_to_move = start_population[key]
      if key.zero?
        @population[6] += count_to_move
        @population[8] = count_to_move
      else
        @population[new_count_key] = count_to_move
      end
    end
  end

  def part1(days = 80)
    days.times { simulate_day }
    @population.values.reduce(:+)
  end

  def part2(days = 256)
    days.times { simulate_day }
    @population.values.reduce(:+)
  end

  private

  def population_to_hash(fish_array)
    {}.tap { |hash| (0..8).each { |i| hash[i] = fish_array.count(i) } }
  end
end


if $PROGRAM_NAME  == __FILE__
  school1 = School.from_file("lib/input.txt")
  part1_answer = school1.part1
  puts "Answer for part 1: #{part1_answer}"

  school2 = School.from_file("lib/input.txt")
  part2_answer = school2.part2
  puts "Answer for part 2: #{part2_answer}"
end

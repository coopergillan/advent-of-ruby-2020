class FishPopulation
  attr_accessor :fish_population

  def initialize(fish_population)
    @fish_population = population_to_hash(fish_population)
  end

  def self.from_file(filepath)
    fish_array = File.read(filepath, chomp: true).split(",").map(&:to_i)
    # fish_population = self.population_to_hash(fish_array)
    new(fish_array)
  end

  def population_to_hash(fish_array)
    fish_population = {}.tap do |hash|
      (0..8).each do |i|
        hash[i] = 0
      end
    end
    fish_array.each { |fish| fish_population[fish] += 1 }
    fish_population
  end

  def simulate_day
    start_population = @fish_population.clone
    puts "start_population: #{start_population}"
    @fish_population.size.times.reverse_each do |key|
      puts "key: #{key}"
      new_count_key = key - 1
      if key == 0
        # add the ones that spawned back up to 6
        @fish_population[6] += start_population[key]
        # Spawn the new ones
        @fish_population[8] = start_population[key]
      else
        puts "@fish_population[new_count_key]: #{@fish_population[new_count_key]}"
        puts "start_population[key]: #{start_population[key]}"
        @fish_population[new_count_key] = start_population[key]
        puts "Current @fish_population: #{@fish_population}"
      end
    end
  end

  def part1(days = 80)
    days.times { simulate_day }

    total_count = @fish_population.values.reduce(:+)
    total_count
  end

  def part2(days = 256)
    days.times { simulate_day }

    total_count = @fish_population.values.reduce(:+)
    total_count
  end

  # private

end

  # def simulate_day
  #   new_fish_count = 0
  #   @fish_population.each_with_index do |fish, idx|
  #     # puts "Checking fish: #{fish} - which should match @fish_population[idx]: #{@fish_population[idx]}"
  #     internal_timer = @fish_population[idx]
  #     if internal_timer.zero?
  #       new_fish_count +=1
  #       internal_timer = 6
  #     else
  #       internal_timer -= 1
  #     end
  #     @fish_population[idx] = internal_timer
  #     # puts "Finished checking fish: #{fish} - which should match @fish_population[idx]: #{@fish_population[idx]}"
  #   end
  #   if !new_fish_count.zero?
  #     new_fish_count.times { @fish_population.push(8) }
  #   end
  # end

  # def part1(days = 80)
  #   days.times { simulate_day }
  #   @fish_population.size
  # end
  #
  # def part1_better_hopefully(days = 80)
  #   simulate(@fish_population, days)
  #   @fish_population.size
  # end
  #
  # def part2(days = 256)
  #   start_population = @fish_population
  #   final = simulate(start_population, 256)
  #   final.size
  # end

# def figure_it_out
# # def figure_it_out(start_population)
#   {
#       0 => 0,
#       1 => 0,
#       2 => 0,
#       3 => 0,
#       4 => 0,
#       5 => 0,
#       6 => 0,
#       7 => 0,
#       8 => 0,
#       }
#   # {}.tap do |hash|
#   #   8.times do |number|
#   #     hash[number] = 0
#   #   end
#   # end
#   # puts "hash: #{hash}"
#   # hash
# end
#
#
# def simulate(population, days)
#   return population if days.zero?
#
#   new_fish = 0
#   puts "Checking day #{days}"
#   # puts "population: #{population}"
#   # puts "population.size: #{population.size}"
#   population.each_with_index do |fish, idx|
#     internal_timer = population[idx]
#     if internal_timer.zero?
#       new_fish += 1
#       internal_timer = 6
#     else
#       internal_timer -= 1
#     end
#     population[idx] = internal_timer
#   end
#   if !new_fish.zero?
#     new_fish.times { population << 8 }
#   end
#   # puts "Have #{days} befopre decrement"
#   days -= 1
#   # puts "Have #{days} after decrement"
#   simulate(population, days)
# end
#
# class School
#   attr_accessor :population
#
#   def initialize(population)
#     @population = population
#   end
#
#   def simulate_day
#     @population
#   end
# end


if $PROGRAM_NAME  == __FILE__
  # fish_population1 = FishPopulation.from_file("lib/input.txt")
  # part1_answer = fish_population1.part1
  # puts "Answer for part 1: #{part1_answer}"

  fish_population2 = FishPopulation.from_file("lib/input.txt")
  # fish_population2 = FishPopulation.new([
# 1,1,1,1,2,1,1,4,1,4,3,1,1,1,1,1,1,1,1,4,1,3,1,1,1,5,1,3,1,4,1,2,1,1,5,1,1,1,1,1,1,1,1,1,1,3,4,1,5,1,1,1,1,1,1,1,1,1,3,1,4,1,1,1,1,3,5,1,1,2,1,1,1,1,4,4,1,1,1,4,1,1,4,2,4,4,5,1,1,1,1,2,3,1,1,4,1,5,1,1,1,3,1,1,1,1,5,5,1,2,2,2,2,1,1,2,1,1,1,1,1,3,1,1,1,2,3,1,5,1,1,1,2,2,1,1,1,1,1,3,2,1,1,1,4,3,1,1,4,1,5,4,1,4,1,1,1,1,1,1,1,1,1,1,2,2,4,5,1,1,1,1,5,4,1,3,1,1,1,1,4,3,3,3,1,2,3,1,1,1,1,1,1,1,1,2,1,1,1,5,1,3,1,4,3,1,3,1,5,1,1,1,1,3,1,5,1,2,4,1,1,4,1,4,4,2,1,2,1,3,3,1,4,4,1,1,3,4,1,1,1,2,5,2,5,1,1,1,4,1,1,1,1,1,1,3,1,5,1,2,1,1,1,1,1,4,4,1,1,1,5,1,1,5,1,2,1,5,1,1,1,1,1,1,1,1,1,1,1,1,3,2,4,1,1,2,1,1,3,2])

  part2_answer = fish_population2.part2
  puts "Answer for part 2: #{part2_answer}"
end

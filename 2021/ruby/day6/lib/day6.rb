class FishPopulation
  attr_accessor :fish_population

  def initialize(fish_population)
    @fish_population = fish_population
  end

  def self.from_file(filepath)
    fish_population = File.read(filepath, chomp:true).split(",").map(&:to_i)
    new(fish_population)
  end

  def simulate_day
    new_fish_count = 0
    @fish_population.each_with_index do |fish, idx|
      # puts "Checking fish: #{fish} - which should match @fish_population[idx]: #{@fish_population[idx]}"
      internal_timer = @fish_population[idx]
      if internal_timer.zero?
        new_fish_count +=1
        internal_timer = 6
      else
        internal_timer -= 1
      end
      @fish_population[idx] = internal_timer
      # puts "Finished checking fish: #{fish} - which should match @fish_population[idx]: #{@fish_population[idx]}"
    end
    if !new_fish_count.zero?
      new_fish_count.times { @fish_population.push(8) }
    end
  end

  def part1(days = 80)
    days.times { simulate_day }
    @fish_population.size
  end

  def part2
  end
end


if $PROGRAM_NAME  == __FILE__
  fish_population1 = FishPopulation.from_file("lib/input.txt")
  part1_answer = fish_population1.part1
  puts "Answer for part 1: #{part1_answer}"

  # fish_population2 = FishPopulation.from_file("lib/input.txt")
  # part2_answer = fish_population2.part2
  # puts "Answer for part 2: #{part2_answer}"
end

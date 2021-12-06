class FishPopulation
  attr_accessor :fish

  def initialize(fish)
    @fish = fish
  end

  def self.from_file(filepath)
    # fish = []
    fish  =  File.read(filepath, chomp:true).split(",").map(&:to_i)
    new(fish)
  end

  def part1
  end

  def part2
  end
end


if $PROGRAM_NAME  == __FILE__
  fish_population1 = FishPopulation.from_file("lib/input.txt")
  # part1_answer = fish_population1.part1
  # puts "Answer for part 1: #{part1_answer}"

  # fish_population2 = FishPopulation.from_file("lib/input.txt")
  # part2_answer = fish_population2.part2
  # puts "Answer for part 2: #{part2_answer}"
end

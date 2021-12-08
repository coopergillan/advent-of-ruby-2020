class LuggageCheck
  attr_accessor :bag_rules

  def initialize(bag_rules)
    @bag_rules = bag_rules
  end

  def self.from_file(filepath)
		new("implement")
    # new(
    #   File.read(filepath, chomp: true).split(/\n\n/).map do |line|
    #     line.chomp.split(/\n/).flatten
    #   end
    #  )
  end

  def part1
  end

  def part2
  end
end


class LuggageRule
  attr_accessor :item_name, :capacity

  def initialize(item_name, capacity)
    @item_name = item_name
    @capacity = capacity
  end
end


if $PROGRAM_NAME  == __FILE__
  puts "Hello world"
  # luggage_check = LuggageCheck.from_file("lib/input.txt")
  #
  # puts "Answer for part 1: #{luggage_check.part1}"
  # puts "Answer for part 2: #{luggage_check.part2}"
end

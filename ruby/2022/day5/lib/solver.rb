class CraneDirector

  attr_accessor :stacks, :instructions

  def initialize(stacks, instructions)
    @stacks = stacks
    @instructions = instructions
  end

  def self.from_file(filepath)
    # Okay, so this input is obviously challenging - going to manually key
    # in the starting stacks for now
    test_stacks = {
      1 => ["Z", "N"],
      2 => ["M", "C", "D"],
      3 => ["P"],
    }

    stacks = {
      1 => ["B", "W", "N"],
      2 => ["L", "Z", "S", "P", "T", "D", "M", "B"],
      3 => ["Q", "H", "Z", "W", "R"],
      4 => ["W", "D", "V", "J", "Z", "R"],
      5 => ["S", "H", "M", "B"],
      6 => ["L", "G", "N", "J", "H", "V", "P", "B"],
      7 => ["J", "Q", "Z", "F", "H", "D", "L", "S"],
      8 => ["W", "S", "F", "J", "G", "Q", "B"],
      9 => ["Z", "W", "M", "S", "C", "D", "J"],
    }

    # The instructions will be array:
    # 0th element is the quantity, 1th the stack to pop off
    # and the 2th the stack to append to
    raw_content = File.read(filepath, chomp: true).split(/\n\n/).pop

    # For processing each line within the separate objects, for example, getting the integer of each line
    instructions = raw_content.split(/\n/).map do |line|
      line.split(/[^0-9]/).reject { |n| n.empty? }.map(&:to_i)
    end

    # Instantiate the top-level class with processed data
    new(stacks, instructions)
  end

  def solve_part1
    instructions.each do |(quantity, source_queue, dest_queue)|
      quantity.times { stacks[dest_queue].append(stacks[source_queue].pop) }
    end

    # Now assemble the final string
    final_string = ""
    (1..9).each do |i|
      final_string += stacks[i].pop
    end
    final_string
  end

  def solve_part2
    instructions.each do |(quantity, source_queue, dest_queue)|
      stacks[dest_queue] += stacks[source_queue].pop(quantity)
    end

    # Now assemble the final string
    final_string = ""
    (1..9).each do |i|
      final_string += stacks[i].pop
    end
    final_string
  end
end

if $PROGRAM_NAME  == __FILE__
  crane_director1 = CraneDirector.from_file("lib/input.txt")

  part1 = crane_director1.solve_part1
  puts "Part one answer: #{part1}"

  crane_director2 = CraneDirector.from_file("lib/input.txt")

  part2 = crane_director2.solve_part2
  puts "Part two answer: #{part2}"
end

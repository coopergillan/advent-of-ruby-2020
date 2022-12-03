class RucksackList

  attr_accessor :input_data

  def initialize(input_data)
    @input_data = input_data
  end

  def self.from_file(filepath)
    new(File.foreach(filepath, chomp: true).to_a)
  end

  def solve_part1
    input_data.reduce(0) do |total_priority, raw_rucksack|
      total_priority + Rucksack.from_raw(raw_rucksack).priority
    end
  end
end

class Rucksack

  ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  attr_accessor :compartment1, :compartment2

  def initialize(compartment1, compartment2)
    @compartment1 = compartment1
    @compartment2 = compartment2
  end

  def self.from_raw(raw_input)
    compartment_size = raw_input.size / 2
    compartment1, compartment2 = raw_input.chars.each_slice(compartment_size).map(&:join)
    new(compartment1, compartment2)
  end

  def common_element
    compartment1.chars.intersection(compartment2.chars).first
  end

  def priority
    ALPHABET.index(common_element) + 1
  end
end

if $PROGRAM_NAME  == __FILE__
  rucksack_list = RucksackList.from_file("lib/input.txt")

  part1 = rucksack_list.solve_part1
  puts "Part one answer: #{part1}"
end

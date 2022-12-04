class RucksackList
  ELF_GROUP_SIZE = 3

  attr_accessor :input_data

  def initialize(input_data)
    @input_data = input_data
  end

  def self.from_file(filepath)
    new(File.foreach(filepath, chomp: true).to_a)
  end

  def solve_part1
    input_data.reduce(0) do |total_priority, raw_rucksack|
      total_priority + Rucksack.new(raw_rucksack).priority
    end
  end

  def solve_part2
    input_data.each_slice(ELF_GROUP_SIZE).reduce(0) do |total_priority, elf_group|
      rucksack_group = RucksackGroup.from_raw(elf_group)
      total_priority + rucksack_group.priority
    end
  end
end

module RucksackCommon
  ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

  def priority
    ALPHABET.index(common_element) + 1
  end
end

class Rucksack
  include RucksackCommon

  attr_accessor :contents, :compartment1, :compartment2

  def initialize(contents)
    @contents = contents
    compartment_size = contents.size / 2
    @compartment1, @compartment2 = contents.chars.each_slice(compartment_size).map(&:join)
  end

  def common_element
    compartment1.chars.intersection(compartment2.chars).first
  end
end

class RucksackGroup
  include RucksackCommon

  attr_accessor :rucksack1, :rucksack2, :rucksack3

  def initialize(rucksacks)
    @rucksack1, @rucksack2, @rucksack3 = rucksacks
  end

  def self.from_raw(raw_input)
    input1, input2, input3 = raw_input
    new([Rucksack.new(input1), Rucksack.new(input2), Rucksack.new(input3)])
  end

  def common_element
    common_elements = rucksack1.contents.chars &
      rucksack2.contents.chars &
      rucksack3.contents.chars
    common_elements.first
  end
end


if $PROGRAM_NAME  == __FILE__
  rucksack_list = RucksackList.from_file("lib/input.txt")

  part1 = rucksack_list.solve_part1
  puts "Part one answer: #{part1}"

  part2 = rucksack_list.solve_part2
  puts "Part two answer: #{part2}"
end

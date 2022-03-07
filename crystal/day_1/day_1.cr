# Advent of Code 2020 Day 1 parts one and two
require "dir"
require "file"
require "path"

FILE_PATH = Path.new(Dir.current, "day_1", "source_data.txt")

def store_source(filename)
  source_numbers = [] of Int32

  puts "Opening #{filename} to store source data"
  File.open(filename) do |file|
    file.each_line do |line|
      source_numbers << line.to_i
    end
  end
  source_numbers
end

def find_sum_elements(source_numbers, desired_sum)
  source_numbers.each do |number|
    needed = desired_sum - number
    if source_numbers.includes? needed
      return [needed, number]
    end
  end
  [] of Int32
end

def answer_part_1
  source_numbers = store_source(FILE_PATH)

  matches = find_sum_elements(source_numbers, 2020)
  puts "Found matches #{matches}"

  product = matches[0] * matches[1]
  puts "Found product #{product}"
  product
end

puts "Answering part 1:"
answer_part_1

def answer_part_2
  source_numbers = store_source(FILE_PATH)

  source_numbers.each_with_index do |number, index|
    next_numbers = source_numbers[index + 1..] + source_numbers[0...index]

    # puts "Assembled next_numbers with length #{next_numbers.size}"
    # puts "Meanwhile source_numbers currently has length #{source_numbers.size}"

    needed = 2020 - number
    # puts "Need to find a sum of needed: #{needed}"
    matches = find_sum_elements(next_numbers, needed)

    if matches.any?
      # puts "Found matches #{matches} to go with #{number}"
      puts "Found number #{number} with matches #{matches}"
      product = number * matches[0] * matches[1]
      puts "Found final answer product #{product}"
      product
    end
  end
end

puts "Answering part 2:"
answer_part_2

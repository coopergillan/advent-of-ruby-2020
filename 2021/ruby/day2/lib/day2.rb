class Submarine
  attr_accessor :instructions, :horizontal_position, :depth, :aim

  def initialize(instructions)
    @instructions = instructions
    @horizontal_position = 0
    @depth = 0
    @aim = 0
  end

  def self.from_file(filepath)
    new(File.foreach(filepath, chomp: true))
  end

  def answer_part1
    navigate_all_part1
    @horizontal_position * @depth
  end

  def answer_part2
    navigate_all_part2
    @horizontal_position * @depth
  end

  def navigate_part1(raw_command)
    command = Command.new(raw_command)
    case command.direction
    when "forward" then @horizontal_position += command.quantity
      when "down" then @depth += command.quantity
      when "up" then @depth -= command.quantity
    end
  end

  def navigate_part2(raw_command)
    command = Command.new(raw_command)
    case command.direction
      when "forward"
        @horizontal_position += command.quantity
        @depth += @aim * command.quantity
      when "down" then @aim += command.quantity
      when "up" then @aim -= command.quantity
    end
  end

  private

  def navigate_all_part1
    @instructions.each { |raw_command| navigate_part1(raw_command) }
  end

  def navigate_all_part2
    @instructions.each { |raw_command| navigate_part2(raw_command) }
  end
end

class Command
  attr_accessor :direction, :quantity

  def initialize(raw_command)
    @direction, raw_quantity = raw_command.split(/ /)
    @quantity = raw_quantity.to_i
  end
end

if $PROGRAM_NAME  == __FILE__
  part1_submarine = Submarine.from_file("lib/input.txt")

  part1_location_product = part1_submarine.answer_part1
  puts "Got #{part1_location_product} for part 1"

  part2_submarine = Submarine.from_file("lib/input.txt")

  part2_location_product = part2_submarine.answer_part2
  puts "Got #{part2_location_product} for part 2"
end

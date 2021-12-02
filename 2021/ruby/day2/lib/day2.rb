class Submarine
  attr_accessor :instructions, :horizontal_position, :depth

  def initialize(instructions)
    @instructions = instructions
    @horizontal_position = 0
    @depth = 0
  end

  def self.from_file(filepath)
    new(File.foreach(filepath, chomp: true))
  end

  def answer_part1
    navigate_all
    @horizontal_position * @depth
  end

  def navigate(command)
    direction, raw_amount = command.split(/ /)
    amount = raw_amount.to_i
    case direction
      when "forward" then @horizontal_position += amount
      when "down" then @depth += amount
      when "up" then @depth -= amount
    end
  end

  private

  def navigate_all
    @instructions.each { |command| navigate(command) }
  end
end

if $PROGRAM_NAME  == __FILE__
  submarine = Submarine.from_file("lib/input.txt")

  part1_location_product = submarine.answer_part1
  puts "Got #{part1_location_product} for part 1"
end

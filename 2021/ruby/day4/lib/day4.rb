class Day4
  attr_accessor :input

  def initialize(input)
    @input = input
  end

  def self.from_file(filepath)
    new(File.foreach(filepath, chomp: true))
  end
end


if $PROGRAM_NAME  == __FILE__
  puts "Hello world - it's time for part 4"

  day4 = Day4.from_file("lib/input.txt")
  puts "Got input for day4: #{day4.input}"
end

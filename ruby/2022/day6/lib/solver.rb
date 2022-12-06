class Buffer
  PART1_MARKER_SIZE = 4
  PART2_MARKER_SIZE = 14

  attr_accessor :input_data

  def initialize(input_data)
    @input_data = input_data
  end

  def self.from_file(filepath)
    # Read the one line in as a string
    new(File.foreach(filepath, chomp: true).first)
  end

  def solve(marker_size)
    (0...input_data.size).each do |window_start|
      window_end = window_start + marker_size
      chars_to_check = input_data.chars[window_start...window_end]
      return window_end if chars_to_check.uniq.size == marker_size
    end
    return 0  # Should never reach here, but zero is technically true :shrug:
  end
end

if $PROGRAM_NAME  == __FILE__
  buffer = Buffer.from_file("lib/input.txt")

  part1 = buffer.solve(Buffer::PART1_MARKER_SIZE)
  puts "Part one answer: #{part1}"

  part2 = buffer.solve(Buffer::PART2_MARKER_SIZE)
  puts "Part two answer: #{part2}"
end

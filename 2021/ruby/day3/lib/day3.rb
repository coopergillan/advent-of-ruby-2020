class DiagnosticReport
  attr_accessor :bits, :entry_length, :report_length

  def initialize(bits)
    @bits = bits.to_a
    @entry_length = @bits.first.size
    @report_length = @bits.size
  end

  def self.from_file(filepath)
    new(File.foreach(filepath, chomp: true))
  end

  def bit_counts
    bit_counts_data = default_bit_counts
    @bits.each do |line|
      line.each_char.to_a.each_with_index do |bit, idx|
        bit_counts_data[idx.to_i] += bit.to_i
      end
    end
    bit_counts_data
  end

  def gamma_rate_binary
    bit_counts_data = bit_counts
    binary_number = ""
    (0...bit_counts_data.size).each do |idx|
      binary_number += (bit_counts_data[idx] > (@bits.size / 2) ? 1 : 0).to_s
    end
    binary_number
  end

  def gamma_rate
    gamma_rate_binary.to_i(2)
  end

  def epsilon_rate_binary
    bit_counts_data = bit_counts
    binary_number = ""
    (0...bit_counts_data.size).each do |idx|
      binary_number += (bit_counts_data[idx] > (@bits.size / 2) ? 0 : 1).to_s
    end
    binary_number
  end

  def epsilon_rate
    epsilon_rate_binary.to_i(2)
  end

  def part1
    gamma_rate * epsilon_rate
  end

  private

  def default_bit_counts
    {}.tap do |bit_counts_data|
      (0...@entry_length).each do |i|
        bit_counts_data[i] = 0
      end
    end
  end

#   def answer_part1
#     navigate_all_part1
#     @horizontal_position * @depth
#   end
#
#   def answer_part2
#     navigate_all_part2
#     @horizontal_position * @depth
#   end
#
#   def navigate_part1(raw_command)
#     command = Command.new(raw_command)
#     case command.direction
#     when "forward" then @horizontal_position += command.quantity
#       when "down" then @depth += command.quantity
#       when "up" then @depth -= command.quantity
#     end
#   end
#
#   def navigate_part2(raw_command)
#     command = Command.new(raw_command)
#     case command.direction
#       when "forward"
#         @horizontal_position += command.quantity
#         @depth += @aim * command.quantity
#       when "down" then @aim += command.quantity
#       when "up" then @aim -= command.quantity
#     end
#   end
#
#   private
#
#   def navigate_all_part1
#     @instructions.each { |raw_command| navigate_part1(raw_command) }
#   end
#
#   def navigate_all_part2
#     @instructions.each { |raw_command| navigate_part2(raw_command) }
#   end
# end
#
# class Command
#   attr_accessor :direction, :quantity
#
#   def initialize(raw_command)
#     @direction, raw_quantity = raw_command.split(/ /)
#     @quantity = raw_quantity.to_i
#   end
end

if $PROGRAM_NAME  == __FILE__
  diagnostic_report = DiagnosticReport.from_file("lib/input.txt")

  part1_power = diagnostic_report.part1
  puts "Got #{part1_power} for part 1"
end

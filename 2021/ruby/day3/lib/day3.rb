class DiagnosticReport
  attr_accessor :bits, :entry_length

  def initialize(bits)
    @bits = bits.to_a
    @entry_length = @bits.first.size
  end

  def self.from_file(filepath)
    new(File.foreach(filepath, chomp: true))
  end

  def bit_counts(bits)
    bit_counts_data = default_bit_counts
    puts "bits: #{bits}"
    bits.each do |line|
      puts "line: #{line}"
      puts "line.class: #{line.class}"
      line.each_char.to_a.each_with_index do |bit, idx|
        bit_counts_data[idx.to_i] += bit.to_i
      end
    end
    bit_counts_data
  end

  def most_common_bit_by_position(bits)
    counts_hash = bit_counts(bits)
    {}.tap do |hash|
      counts_hash.each do |bit_position, count|
        hash[bit_position] = (counts_hash[bit_position] > bits.size / 2 ? 1 : 0)
      end
    end
  end

  def gamma_rate_binary
    most_common_bit_by_position(@bits).reduce("") do |binary_number, (_, most_common)|
      binary_number += most_common.to_s
    end
  end

  def gamma_rate
    gamma_rate_binary.to_i(2)
  end

  def epsilon_rate_binary
    binary_number = ""
    most_common_bit_by_position(@bits).reduce("") do |binary_number, (_, most_common)|
      binary_number += (most_common.zero? ? 1 : 0).to_s
    end
  end

  def epsilon_rate
    epsilon_rate_binary.to_i(2)
  end

  def part1
    gamma_rate * epsilon_rate
  end

  # def oxygen_generator_rating_binary
  #   bits_data = common_bit_by_position(@bits)
  #   # bits_data = common_bit_by_position(bit_counts(@bits), @report_length)
  #
  #   chars = []
  #   (0...bits_data.size).each do |idx|
  #     # puts "bits_data: #{bits_data}"
  #     # puts "idx: #{idx}"
  #     # puts "most_common: #{most_common}"
  #     # puts
  #     @bits.each do |bit|
  #       # puts "bit: #{bit}"
  #       # puts "bit.chars[idx]: #{bit.chars[idx]}"
  #       # puts "bit.chars[idx].class: #{bit.chars[idx].class}"
  #       # puts "most_common: #{most_common}"
  #       # puts "most_common.class: #{most_common.class}"
  #       most_common = bits_data[idx]
  #       if bit.chars[idx].to_i == most_common
  #         chars.push(bit)
  #       end
  #     end
  #   end
  #   if chars.size == 1
  #     return chars.first
  #   else
  #     chars = filter_bits(chars, common_bit_by_position(chars)
  #     # chars = filter_bits(chars, common_bit_by_position(bit_counts(chars), chars.first.size))
  #     if chars.size == 1
  #       return chars.first
  #     else
  #       chars = filter_bits(chars, common_bit_by_position(chars)
  #       # chars = filter_bits(chars, common_bit_by_position(bit_counts(chars), chars.first.size))
  #     end
  #   end
  #   chars
  # end

  def oxygen_generator_rating
    oxygen_generator_rating_binary.to_i(2)
  end

  def co2_scrubber_rating
    5
  end

  def life_support_rating
    oxygen_generator_rating * co2_scrubber_rating
  end

  def part2
    life_support_rating
  end

  private

  def default_bit_counts
    {}.tap do |bit_counts_data|
      (0...@entry_length).each do |i|
        bit_counts_data[i] = 0
      end
    end
  end
end

if $PROGRAM_NAME  == __FILE__
  diagnostic_report = DiagnosticReport.from_file("lib/input.txt")

  part1_power = diagnostic_report.part1
  puts "Got #{part1_power} for part 1"
end

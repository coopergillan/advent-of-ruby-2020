module Day2
  class PasswordList
    attr_accessor :password_list, :entry_counts

    def initialize(password_list)
      @password_list = password_list
    end

    def self.from_file(filepath)
      new(File.foreach(filepath).map { |line| line.chomp })
    end

    def count_valid_entries(entry_klass)
      @password_list.map { |raw_entry| entry_klass.new(raw_entry).valid? }.count(true)
    end
  end

  class Part1
    class Entry
      attr_reader :min_chars, :max_chars, :char, :password

      def initialize(raw_entry)
        char_limits, raw_char, @password = raw_entry.split(" ")
        @min_chars, @max_chars = char_limits.split("-").map { |raw_char| raw_char.to_i }
        @char = raw_char.split(":").first
      end

      def valid?
        @password.count(@char) >= @min_chars && @password.count(@char) <= @max_chars
      end
    end
  end
end

if $PROGRAM_NAME  == __FILE__
  day2 = Day2::PasswordList.from_file("lib/day2_data.txt")

  puts "Answering part 1"
  valid_entries = day2.count_valid_entries(Day2::Part1::Entry)
  puts "Valid password entries for part 1: #{valid_entries}"
end

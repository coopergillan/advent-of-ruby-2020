module Day2
  class PasswordList
    attr_accessor :password_list

    def initialize(password_list)
      @password_list = password_list
    end

    def self.from_file(filepath)
      new(File.foreach(filepath).map(&:chomp))
    end

    def count_valid_entries(entry_klass)
      @password_list.reduce(0) do |valid_entries, raw_entry|
        valid_entries + (entry_klass.new(raw_entry).valid? ? 1 : 0)
      end
    end
  end

  class Part1
    class Entry
      attr_reader :min_chars, :max_chars, :char, :password

      def initialize(raw_entry)
        char_limits, raw_char, @password = raw_entry.split(" ")
        @min_chars, @max_chars = char_limits.split("-").map(&:to_i)
        @char = raw_char.split(":").first
      end

      def valid?
        @password.count(@char) >= @min_chars && @password.count(@char) <= @max_chars
      end
    end
  end

  class Part2
    class Entry
      attr_reader :position1, :position2, :char, :password

      def initialize(raw_entry)
        char_positions, raw_char, @password = raw_entry.split(" ")
        @position1, @position2 = char_positions.split("-").map(&:to_i)
        @char = raw_char.split(":").first
      end

      def valid?
        [position1_match?, position2_match?].one?
      end

      private

      def position1_match?
        @password[@position1 - 1] == @char
      end

      def position2_match?
        @password[@position2 - 1] == @char
      end
    end
  end
end

if $PROGRAM_NAME  == __FILE__
  day2 = Day2::PasswordList.from_file("lib/day2_data.txt")

  puts "Answering part 1"
  valid_entries = day2.count_valid_entries(Day2::Part1::Entry)
  puts "Valid password entries for part 1: #{valid_entries}"

  puts "Answering part 2"
  valid_entries = day2.count_valid_entries(Day2::Part2::Entry)
  puts "Valid password entries for part 2: #{valid_entries}"
end

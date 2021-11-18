module Day2
  class PasswordList
    attr_accessor :password_list

    def initialize(password_list)
      @password_list = password_list
    end

    def self.from_file(filepath)
      new(File.foreach(filepath).map { |line| line.chomp })
    end
  end

  class Entry
    attr_accessor :min_chars, :max_chars, :char, :password

    def initialize(min_chars, max_chars, char, password)
      @min_chars = min_chars
      @max_chars = max_chars
      @char = char
      @password = password
    end
  end
end

if $PROGRAM_NAME  == __FILE__
  puts "hello world"
  # day2 = Day2.from_file("lib/day2_data.txt")

  # puts "Answering part 1"
  # day2.answer_part1(2020)
  #
  # puts "Answering part 2"
  # day2.answer_part2(2020)
end

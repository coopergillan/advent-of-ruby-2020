# Advent of Code 2020 Day 1 parts one and two
require "dir"
require "file"
require "path"

FILE_PATH = Path.new(Dir.current, "day_2", "source_data.txt")

module Day2
  class InputReader
    def initialize(input : String)
      @lower_bound = 0
      @upper_bound = 0
      @letter = ""
      @password = ""

      raw_range, raw_letter, raw_password = input.split(" ")

      @lower_bound, @upper_bound = raw_range.split("-").map { |bound| bound.to_i }
      @letter = raw_letter.rstrip(":")
      @password = raw_password
    end

    # Pretty sure there is a more crystal way to do all these setters, but
    # since the input is only parsed and not a property, I wasn't able to
    # get it with the time allowed
    def lower_bound
      @lower_bound
    end

    def upper_bound
      @upper_bound
    end

    def letter
      @letter
    end

    def password
      @password
    end
  end

  module Part1
    class Checker
      property valid_passwords
      property input_file : Path
      # property input_reader : Day2::InputReader # Couldn't get this to work
      # This would mean we wouldn't need to repeat the initialize method
      # It resulted in this error:
      #
      # Error: instance variable '@validator' of Day2::Checker must be Day2::InputReader+, not Day2::InputReader.class

      def initialize(@input_file)
        @valid_passwords = 0
      end

      def check_input
        File.open(input_file) do |file|
          file.each_line do |line|
            input_reader = Day2::Part1::InputReader.new(line)
            if input_reader.password_valid?
              @valid_passwords += 1
            end
          end
        end
        puts "Found #{valid_passwords} valid passwords for part 1 in #{input_file}"
      end
    end

    class InputReader < Day2::InputReader
      def password_valid?
        @password.count(@letter) <= @upper_bound && @password.count(@letter) >= @lower_bound
      end
    end
  end

  module Part2
    class InputReader < Day2::InputReader
      def first_matches?
      index = @lower_bound - 1
      @password.byte_at(index) == @letter.byte_at(0)
      end

      def second_matches?
        index = @upper_bound - 1
        @password.byte_at(index) == @letter.byte_at(0)
      end

      def password_valid?
        if (!first_matches? && !second_matches?) || (first_matches? && second_matches?)
          return false
        end
        if first_matches? || second_matches?
          return true
        end
      end
    end

    class Checker
      property valid_passwords
      property input_file : Path

      def initialize(@input_file)
        @valid_passwords = 0
      end

      def check_input
        File.open(input_file) do |file|
          file.each_line do |line|
            input_reader = Day2::Part2::InputReader.new(line)
            if input_reader.password_valid?
              @valid_passwords += 1
            end
          end
        end
        puts "Found #{valid_passwords} valid passwords for part 2 in #{input_file}"
      end
    end
  end
end

# main function
part1_main_checker = Day2::Part1::Checker.new(FILE_PATH)
part1_main_checker.check_input

part2_main_checker = Day2::Part2::Checker.new(FILE_PATH)
part2_main_checker.check_input

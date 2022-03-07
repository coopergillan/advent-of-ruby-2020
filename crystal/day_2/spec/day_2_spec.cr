# Advent of Code 2020 Day 2 part one
require "spec"
require "../../day_2"

describe Day2 do
  context "InputReader" do
    describe "#initialize" do
      it "sets attributes correctly" do
        input = "1-3 g: abcdefg"
        input_reader = Day2::InputReader.new(input)

        input_reader.lower_bound.should eq 1
        input_reader.upper_bound.should eq 3
        input_reader.password.should eq "abcdefg"
        input_reader.letter.should eq "g"
      end
    end
  end

  context "Part1 classes" do
    describe "InputReader" do
      describe "#password_valid?" do
        it "finds valid passwords for part one rules" do
          input = "1-3 g: abcdefg"
          input_reader = Day2::Part1::InputReader.new(input)

          input_reader.password_valid?.should be_true
        end

        it "finds invalid passwords for part one rules" do
          input = "2-3 g: abcdefg"
          input_reader = Day2::Part1::InputReader.new(input)

          input_reader.password_valid?.should be_false
        end
      end
    end

    describe "Checker" do
      describe "#initialize" do
        it "sets attributes correctly" do
          checker = Day2::Part1::Checker.new(Path.new("fake_file.txt"))

          checker.valid_passwords.should eq 0
          checker.input_file.should eq Path["fake_file.txt"]
        end
      end

      describe "#check_input" do
        it "checks input file and counts valid passwords" do
          input_file = Path.new(Dir.current, "spec", "day_2", "spec_input.txt")
          checker = Day2::Part1::Checker.new(input_file)

          checker.check_input
          checker.valid_passwords.should eq 2
        end
      end
    end
  end

  context "Part2 classes" do
    describe "InputReader" do
      it "finds valid passwords with part two rules" do
        input = "1-7 g: abcdefg"
        input_reader = Day2::Part2::InputReader.new(input)
        input_reader.password_valid?.should be_true
      end

      it "finds invalid passwords with no match according to part two rules" do
        input = "4-6 g: abcdefg"
        input_reader = Day2::Part2::InputReader.new(input)
        input_reader.password_valid?.should be_false
      end

      it "finds invalid passwords with double match according to part two rules" do
        input = "4-7 g: abcgefg"
        input_reader = Day2::Part2::InputReader.new(input)
        input_reader.password_valid?.should be_false
      end
    end

    describe "Checker" do
      describe "#check_input" do
        it "checks input file and counts valid passwords per part 2 rules" do
          input_file = Path.new(Dir.current, "spec", "day_2", "spec_input.txt")
          checker = Day2::Part2::Checker.new(input_file)

          checker.check_input
          checker.valid_passwords.should eq 1
        end
      end
    end
  end
end

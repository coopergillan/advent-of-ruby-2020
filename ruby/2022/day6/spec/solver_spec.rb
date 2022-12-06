require "solver"

describe Buffer do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to the data" do
			expect(subject.input_data).to eq("mjqjpqmgbljsphdztnvjfqwrcgsmlb")
    end
  end

  context "#solve_part1" do
    it "solves part one for multiple examples" do
      test_cases = {
        "mjqjpqmgbljsphdztnvjfqwrcgsmlb" => 7,
        "bvwbjplbgvbhsrlpgdmjqwftvncz" => 5,
        "nppdvjthqldpwncqszvftbrmjlhg" => 6,
        "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" => 10,
        "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" => 11,
      }
      test_cases.each do |input_string, expected_answer|
        expect(described_class.new(input_string).solve(Buffer::PART1_MARKER_SIZE)).to eq(expected_answer)
      end
    end
  end

  context "#solve_part2" do
    it "solves part two for multiple examples" do
      test_cases = {
        "mjqjpqmgbljsphdztnvjfqwrcgsmlb" => 19,
        "bvwbjplbgvbhsrlpgdmjqwftvncz" => 23,
        "nppdvjthqldpwncqszvftbrmjlhg" => 23,
        "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" => 29,
        "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" => 26,
      }
      test_cases.each do |input_string, expected_answer|
        expect(described_class.new(input_string).solve(Buffer::PART2_MARKER_SIZE)).to eq(expected_answer)
      end
    end
  end
end

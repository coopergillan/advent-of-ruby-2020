require "solver"

describe RocksPaperScissors do
  subject { RocksPaperScissors.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to the data" do
      expect(subject.input_data).to match_array([
        [],
        [4000],
        [5000, 6000],
        [7000, 8000, 9000],
        [10000],
      ])
    end
  end

  context "#solve_part1" do
    it "solves part one" do
      expect(subject.solve_part1).to eq("something")  # Taken directly from instructions
    end
  end

  context "#solve_part2" do
    it "solves part two" do
      expect(subject.solve_part2).to eq("something else")  # Taken directly from instructions
    end
  end
end

require "solver"

describe TopLevelClass do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    xit "converts a file path to the data" do
      expect(subject.input_data).to match_array([
        [4, 7], [3, 3], [2, 9]
      ])
    end
  end

  context "#solve_part1" do
    it "solves part one" do
      expect(subject.solve_part1).to eq(95437)
    end
  end

  # context "#solve_part2" do
  #   it "solves part two" do
  #     expect(subject.solve_part2).to eq(8)
  #   end
  # end
end

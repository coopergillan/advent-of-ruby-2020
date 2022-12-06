require "solver"

describe CraneDirector do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "starts with the correct data" do
      expect(subject.stacks).to include(
        1 => ["Z", "N"],
        2 => ["M", "C", "D"],
        3 => ["P"],
      )
      expect(subject.instructions).to match_array([
        [1, 2, 1],
        [3, 1, 3],
        [2, 2, 1],
        [1, 1, 2],
      ])
    end
  end

  context "#solve_part1" do
    it "solves part one" do
      expect(subject.solve_part1).to eq("CMZ")
    end
  end

  context "#solve_part2" do
    it "solves part two" do
      expect(subject.solve_part2).to eq(8)
    end
  end
end

describe ParticularClass do
  context "#from_raw" do
    let(:raw_input) { ["A", "Z"] }
    subject { described_class.from_raw(raw_input) }

    it "translates the raw input into separate values" do
      expect(subject.input1).to eq("A")
      expect(subject.input2).to eq("Z")
    end
  end
end

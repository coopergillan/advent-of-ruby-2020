require "solver"

describe CathodeRayTube do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to the data" do
      expect(subject.instructions[...5]).to match_array([
        ["addx", 15],
        ["addx", -11],
        ["addx", 6],
        ["addx", -3],
        ["addx", 5],
      ])
      expect(subject.instructions[-4..]).to match_array([
        ["addx", -11],
        ["noop"],
        ["noop"],
        ["noop"],
      ])
    end
  end

  xcontext "#solve_part1" do
    it "solves part one" do
      expect(subject.solve_part1).to eq(5)
    end
  end

  xcontext "#solve_part2" do
    it "solves part two" do
      expect(subject.solve_part2).to eq(8)
    end
  end
end

# describe ParticularClass do
#   context "#from_raw" do
#     let(:raw_input) { ["A", "Z"] }
#     subject { described_class.from_raw(raw_input) }
#
#     it "translates the raw input into separate values" do
#       expect(subject.input1).to eq("A")
#       expect(subject.input2).to eq("Z")
#     end
#   end
# end

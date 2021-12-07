require "day7"

describe CrabSchool do
  context "#from_file" do
    subject { described_class.from_file("spec/test_input.txt") }

    it "creates array of starting crab positions days" do
      expect(subject.positions).to match_array([
				16, 1, 2, 0, 4, 2, 7, 1, 2, 14,
      ])
    end
  end

  context "answer first part" do
    let(:start_positions) { [16, 1, 2, 0, 4, 2, 7, 1, 2, 14] }
    subject { described_class.new(start_positions) }

    context "#part1" do
      it "calculates the fuel for moving to mean position" do
        expect(subject.part1).to eq(37)
      end
    end

    context "#part2" do
      it "calculates fuel for a move with new rules" do
        expect(subject.fuel_for_move(16, 5)).to eq(66)
      end

      it "calculates the fuel with new rules" do
        expect(subject.part2).to eq(168)
      end
    end
  end
end

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

    context "#simulate_day" do
      it "updates counts for each fish after one day" do
        expect(subject.part1).to eq(37)
      end
    end
  end
end

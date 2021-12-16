require "day11"

describe Cavern do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#new" do
    it "gets a 10x10 array of Octopus objects" do
      expect(subject.octopus_map).to be_a(Array)
      expect(subject.height).to eq(10)
      expect(subject.width).to eq(10)

      expect(subject.octopus_map.first.first).to be_a(Octopus)
    end
  end

  context "given a point on the map" do
    context "when checking corners" do
      let(:top_left) { [0, 0] }
      let(:bottom_left) { [9, 0] }
      let(:top_right) { [0, 9] }
      let(:bottom_right) { [9, 9] }

      it "can get the neighboring coordinates" do
        expect(subject.raw_neighbor_coords(top_left)).to eq([[0, 1], [1, 0], [1, 1]])
        expect(subject.raw_neighbor_coords(bottom_left)).to eq([[8, 0], [8, 1], [9, 1]])
        expect(subject.raw_neighbor_coords(top_right)).to eq([[0, 8], [1, 8], [1, 9]])
        expect(subject.raw_neighbor_coords(bottom_right)).to eq([[8, 8], [8, 9], [9, 8]])
      end

      xit "can get the neighboring values" do
        expect(subject.neighbors(top_left)).to eq([1, 3])
        expect(subject.neighbors(bottom_left)).to eq([8, 8])
        expect(subject.neighbors(top_right)).to eq([1, 1])
        expect(subject.neighbors(bottom_right)).to eq([7, 9])
      end
    end

    context "when checking edge/border pieces" do
      let(:left_border) { [2, 0] }
      let(:right_border) { [3, 9] }
      let(:top_border) { [0, 6] }
      let(:bottom_border) { [9, 3] }

      it "can get the neighboring coordinates" do
        expect(subject.raw_neighbor_coords(left_border)).to eq([
          [1, 0], [1, 1], [2, 1], [3, 0], [3, 1],
        ])
        expect(subject.raw_neighbor_coords(right_border)).to eq([
          [2, 8], [2, 9], [3, 8], [4, 8], [4, 9],
        ])
        expect(subject.raw_neighbor_coords(top_border)).to eq([
          [0, 5], [0, 7], [1, 5], [1, 6], [1, 7],
        ])
        expect(subject.raw_neighbor_coords(bottom_border)).to eq([
          [8, 2], [8, 3], [8, 4], [9, 2], [9, 4],
        ])
      end

      xit "can get the neighboring points" do
        expect(subject.neighbors(left_border)).to eq([3, 8, 8])
        expect(subject.neighbors(right_border)).to eq([8, 2, 8])
        expect(subject.neighbors(top_border)).to eq([4, 2, 4])
        expect(subject.neighbors(bottom_border)).to eq([9, 9, 5])
      end
    end

    context "when checking pieces in the middle" do
      let(:mid1) { [2, 3] }
      let(:mid2) { [7, 6] }
      it "can get the neighboring coordinates" do
        expect(subject.raw_neighbor_coords(mid1)).to eq([
          [1, 2], [1, 3], [1, 4], [2, 2], [2, 4], [3, 2], [3, 3], [3, 4],
        ])
        expect(subject.raw_neighbor_coords(mid2)).to eq([
          [6, 5], [6, 6], [6, 7], [7, 5], [7, 7], [8, 5], [8, 6], [8, 7],
        ])
      end

      xit "can get the neighboring points" do
        expect(subject.neighbors(mid1)).to eq([5, 7, 7, 7])
        expect(subject.neighbors(mid2)).to eq([7, 9, 9, 7])
      end
    end
  end

  context "when a step occurs" do
    subject { described_class.new([
      [4, 5, 8, 5],
      [6, 4, 5, 5],
      [4, 1, 3, 3],
      [5, 7, 3, 8],
    ]) }
    it "increments each square" do
      subject.step
      expect(subject.octopus_map).to match_array([
        [5, 6, 9, 6],
        [7, 5, 6, 6],
        [5, 2, 4, 4],
        [6, 8, 4, 9],
      ])
    end
  end
end

describe Octopus do
  subject { described_class.new(6) }
  context "#increment_and_flash" do
    context "when below energy level 9" do
      it "increments its energy level by 1 when below 9 and does not flash" do
        expect(subject.energy_level).to eq(6)
        expect(subject.increment_and_flash).to eq(0)
        expect(subject.energy_level).to eq(7)
      end
    end

    context "when at energy level 9" do
      subject { described_class.new(9) }
      it "goes to 0 energy level when incremented from 9 and returns one flash" do
        expect(subject.energy_level).to eq(9)
        expect(subject.increment_and_flash).to eq(1)
        expect(subject.energy_level).to eq(0)
      end
    end
  end
end

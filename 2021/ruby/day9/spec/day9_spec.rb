require "day9"

describe LavaTubeSurfer do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#new" do
    it "gets an array of arrays for the lava tube heightmap" do
      expect(subject.heightmap).to match_array([
        [2, 1, 9, 9, 9, 4, 3, 2, 1, 0],
        [3, 9, 8, 7, 8, 9, 4, 9, 2, 1],
        [9, 8, 5, 6, 7, 8, 9, 8, 9, 2],
        [8, 7, 6, 7, 8, 9, 6, 7, 8, 9],
        [9, 8, 9, 9, 9, 6, 5, 6, 7, 8],
      ])
      expect(subject.height).to eq(5)
      expect(subject.width).to eq(10)
    end
  end

  context "given a point on the map" do
    # let(:edge) { [4, 7] }
    # let(:middle) { [3, 8] }
    context "when checking corners" do
      let(:top_left) { [0, 0] }
      let(:bottom_left) { [4, 0] }
      let(:top_right) { [0, 9] }
      let(:bottom_right) { [4, 9] }

      it "can get the neighboring points" do
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
      let(:bottom_border) { [4, 5] }
      it "can get the neighboring points" do
        expect(subject.neighbors(left_border)).to eq([3, 8, 8])
        expect(subject.neighbors(right_border)).to eq([8, 2, 8])
        expect(subject.neighbors(top_border)).to eq([4, 2, 4])
        expect(subject.neighbors(bottom_border)).to eq([9, 9, 5])
      end
    end

    context "when checking pieces in the middle" do
      it "can get the neighboring points" do
        expect(subject.neighbors([2, 3])).to eq([5, 7, 7, 7])
        expect(subject.neighbors([3, 8])).to eq([7, 9, 9, 7])
      end
    end
  end
end

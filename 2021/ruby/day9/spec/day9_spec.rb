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
    end
  end

  context "given a point on the map" do
    # let(:edge) { [4, 7] }
    # let(:middle) { [3, 8] }
    context "when checking corners" do
      let(:top_left) { [0, 0] }
      let(:bottom_left) { [0, 4] }

      it "can get the neighboring points" do
        expect(subject.neighbors(top_left)).to eq([1, 3])
        expect(subject.neighbors(bottom_left)).to eq([1, 3])
      end
    end
  end
end

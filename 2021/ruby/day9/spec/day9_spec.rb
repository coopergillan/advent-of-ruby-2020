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
    context "when checking corners" do
      let(:top_left) { [0, 0] }
      let(:bottom_left) { [4, 0] }
      let(:top_right) { [0, 9] }
      let(:bottom_right) { [4, 9] }

      it "can get the neighboring coordinates" do
        expect(subject.raw_neighbor_coords(top_left)).to eq([[0, 1], [1, 0]])
        expect(subject.raw_neighbor_coords(bottom_left)).to eq([[3, 0], [4, 1]])
        expect(subject.raw_neighbor_coords(top_right)).to eq([[0, 8], [1, 9]])
        expect(subject.raw_neighbor_coords(bottom_right)).to eq([[4, 8], [3, 9]])
      end

      it "can get the neighboring values" do
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

      it "can get the neighboring coordinates" do
        expect(subject.raw_neighbor_coords(left_border)).to eq([
          [1, 0], [2, 1], [3, 0],
        ])
        # expect(subject.raw_neighbor_coords(right_border)).to eq([8, 2, 8])
        # expect(subject.raw_neighbor_coords(top_border)).to eq([4, 2, 4])
        # expect(subject.raw_neighbor_coords(bottom_border)).to eq([9, 9, 5])
      end

      it "can get the neighboring points" do
        expect(subject.neighbors(left_border)).to eq([3, 8, 8])
        expect(subject.neighbors(right_border)).to eq([8, 2, 8])
        expect(subject.neighbors(top_border)).to eq([4, 2, 4])
        expect(subject.neighbors(bottom_border)).to eq([9, 9, 5])
      end
    end

    context "when checking pieces in the middle" do
      let(:mid1) { [2, 3] }
      let(:mid2) { [3, 8] }
      it "can get the neighboring coordinates" do
        expect(subject.raw_neighbor_coords(mid1)).to eq([
          [2, 2], [1, 3], [2, 4], [3, 3],
        ])
        expect(subject.raw_neighbor_coords(mid2)).to eq([
          [3, 7], [2, 8], [3, 9], [4, 8],
        ])
      end

      it "can get the neighboring points" do
        expect(subject.neighbors(mid1)).to eq([5, 7, 7, 7])
        expect(subject.neighbors(mid2)).to eq([7, 9, 9, 7])
      end
    end
  end

  context "methods to finish part1" do
    let(:has_higher) { [
      [0, 1],
      [0, 9],
      [2, 2],
      [4, 6],
    ] }
    let(:not_higher) { [
      [0, 2],
      [3, 6],
      [4, 9],
      [4, 3],
    ] }
    context "#higher_neighbors?" do
      it "can find whether all neighbors are higher or not" do
        has_higher.each do |coords|
          expect(subject.higher_neighbors?(coords)).to be(true)
        end

        not_higher.each do |coords|
          expect(subject.higher_neighbors?(coords)).to be(false)
        end
      end
    end

    context "#risk_level" do
      it "calculates risk_level" do
        expect(subject.risk_level(has_higher.first)).to eq(2)
        expect(subject.risk_level(has_higher.last)).to eq(6)
      end
    end
  end

  context "#part1" do
    it "can answer part1 by counting points with all higher neighbors" do
      expect(subject.part1).to eq(15)
    end
  end

  context "answering part2" do
    context "when identifying and sizing basins" do
      let(:low_point1) { [0, 1] }
      let(:low_point2) { [0, 9] }
      let(:low_point3) { [2, 2] }
      it "can identify whether a point is in a basin" do
        expect(subject.in_basin?([0, 0])).to be(false)
        expect(subject.in_basin?([1, 1])).to be(true)
      end

      it "returns nil if a point is not a low point" do
        expect(subject.basin_size([0, 0])).to be(nil)
      end

      it "counts the size of the basin for a low point" do
        # expect(subject.basin_size(low_point1)).to eq(3)
        # expect(subject.basin_size(low_point2)).to eq(9)
        expect(subject.basin_size(low_point2)).to eq(14)
      end
    end

    it "gets the final answer by multiplying the size of three biggest basins together" do
      expect(subject.part2).to eq(9 * 14 * 9)
    end
  end
end

require "day11"

# def octo(energy_level)
#   Octopus.new(energy_level)
# end

describe Cavern do
  subject { described_class.from_file("spec/test_input.txt") }

  context "when map is created" do
    it "gets a 10x10 array of Octopus objects" do
      expect(subject.octopus_map).to be_a(Array)
      expect(subject.height).to eq(10)
      expect(subject.width).to eq(10)

      expect(subject.octopus_map.first.first).to be_a(Integer)
    end
  end

  context "answering part 1" do
    it "gets the answer to part1" do
      expect(subject.part1).to eq(1656)
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

  context "#step" do
    context "when running for a smaller example" do
      subject { described_class.new([
        [4, 5, 8, 5],
        [6, 4, 5, 5],
        [4, 1, 3, 3],
        [5, 7, 3, 8],
      ]) }
      it "increments each square by one for one step" do
        subject.step
        expect(subject.octopus_map).to match_array([
          [5, 6, 9, 6],
          [7, 5, 6, 6],
          [5, 2, 4, 4],
          [6, 8, 4, 9],
        ])
      end

      it "increments each square and neighbors of flashing octopi, counts flashes" do
        2.times { subject.step }
        expect(subject.octopus_map).to match_array([
          [6, 8, 0, 8],
          [8, 7, 8, 8],
          [6, 3, 6, 6],
          [7, 9, 6, 0],
        ])
        expect(subject.flashes).to eq(2)
      end

      it "increments each square and neighbors of flashing octopi, counts flashes" do
        4.times { subject.step }
        expect(subject.octopus_map).to match_array([
          [0, 1, 1, 9],
          [0, 9, 9, 9],
          [9, 6, 8, 7],
          [9, 0, 8, 1],
        ])
        expect(subject.flashes).to eq(3)
      end
    end

    context "when running for the main example" do
      subject { described_class.from_file("spec/test_input.txt") }

      it "increments and counts flashes for 2 steps" do
        expect(subject.octopus_map).to match_array([
          [5, 4, 8, 3, 1, 4, 3, 2, 2, 3],
          [2, 7, 4, 5, 8, 5, 4, 7, 1, 1],
          [5, 2, 6, 4, 5, 5, 6, 1, 7, 3],
          [6, 1, 4, 1, 3, 3, 6, 1, 4, 6],
          [6, 3, 5, 7, 3, 8, 5, 4, 7, 8],
          [4, 1, 6, 7, 5, 2, 4, 6, 4, 5],
          [2, 1, 7, 6, 8, 4, 1, 7, 2, 1],
          [6, 8, 8, 2, 8, 8, 1, 1, 3, 4],
          [4, 8, 4, 6, 8, 4, 8, 5, 5, 4],
          [5, 2, 8, 3, 7, 5, 1, 5, 2, 6],
        ])
        expect(subject.flashes).to eq(0)

        subject.step

        expect(subject.flashes).to eq(0)
        expect(subject.octopus_map).to match_array([
          [6, 5, 9, 4, 2, 5, 4, 3, 3, 4],
          [3, 8, 5, 6, 9, 6, 5, 8, 2, 2],
          [6, 3, 7, 5, 6, 6, 7, 2, 8, 4],
          [7, 2, 5, 2, 4, 4, 7, 2, 5, 7],
          [7, 4, 6, 8, 4, 9, 6, 5, 8, 9],
          [5, 2, 7, 8, 6, 3, 5, 7, 5, 6],
          [3, 2, 8, 7, 9, 5, 2, 8, 3, 2],
          [7, 9, 9, 3, 9, 9, 2, 2, 4, 5],
          [5, 9, 5, 7, 9, 5, 9, 6, 6, 5],
          [6, 3, 9, 4, 8, 6, 2, 6, 3, 7],
        ])

        subject.step
        expect(subject.flashes).to eq(35)
        expect(subject.octopus_map).to match_array([
          [8, 8, 0, 7, 4, 7, 6, 5, 5, 5],
          [5, 0, 8, 9, 0, 8, 7, 0, 5, 4],
          [8, 5, 9, 7, 8, 8, 9, 6, 0, 8],
          [8, 4, 8, 5, 7, 6, 9, 6, 0, 0],
          [8, 7, 0, 0, 9, 0, 8, 8, 0, 0],
          [6, 6, 0, 0, 0, 8, 8, 9, 8, 9],
          [6, 8, 0, 0, 0, 0, 5, 9, 4, 3],
          [0, 0, 0, 0, 0, 0, 7, 4, 5, 6],
          [9, 0, 0, 0, 0, 0, 0, 8, 7, 6],
          [8, 7, 0, 0, 0, 0, 6, 8, 4, 8],
        ])
      end

      it "increments and counts flashes for 10 steps" do
        expect(subject.octopus_map).to match_array([
          [5, 4, 8, 3, 1, 4, 3, 2, 2, 3],
          [2, 7, 4, 5, 8, 5, 4, 7, 1, 1],
          [5, 2, 6, 4, 5, 5, 6, 1, 7, 3],
          [6, 1, 4, 1, 3, 3, 6, 1, 4, 6],
          [6, 3, 5, 7, 3, 8, 5, 4, 7, 8],
          [4, 1, 6, 7, 5, 2, 4, 6, 4, 5],
          [2, 1, 7, 6, 8, 4, 1, 7, 2, 1],
          [6, 8, 8, 2, 8, 8, 1, 1, 3, 4],
          [4, 8, 4, 6, 8, 4, 8, 5, 5, 4],
          [5, 2, 8, 3, 7, 5, 1, 5, 2, 6],
        ])
        expect(subject.flashes).to eq(0)

        10.times { subject.step }

        expect(subject.flashes).to eq(204)
        expect(subject.octopus_map).to match_array([
          [0, 4, 8, 1, 1, 1, 2, 9, 7, 6],
          [0, 0, 3, 1, 1, 1, 2, 0, 0, 9],
          [0, 0, 4, 1, 1, 1, 2, 5, 0, 4],
          [0, 0, 8, 1, 1, 1, 1, 4, 0, 6],
          [0, 0, 9, 9, 1, 1, 1, 3, 0, 6],
          [0, 0, 9, 3, 5, 1, 1, 2, 3, 3],
          [0, 4, 4, 2, 3, 6, 1, 1, 3, 0],
          [5, 5, 3, 2, 2, 5, 2, 3, 5, 0],
          [0, 5, 3, 2, 2, 5, 0, 6, 0, 0],
          [0, 0, 3, 2, 2, 4, 0, 0, 0, 0],
        ])
      end

      it "increments and counts flashes for the 100 steps in the instructions" do
        100.times { subject.step }

        expect(subject.flashes).to eq(1656)
        expect(subject.octopus_map).to match_array([
          [0, 3, 9, 7, 6, 6, 6, 8, 6, 6],
          [0, 7, 4, 9, 7, 6, 6, 9, 1, 8],
          [0, 0, 5, 3, 9, 7, 6, 9, 3, 3],
          [0, 0, 0, 4, 2, 9, 7, 8, 2, 2],
          [0, 0, 0, 4, 2, 2, 9, 8, 9, 2],
          [0, 0, 5, 3, 2, 2, 2, 8, 7, 7],
          [0, 5, 3, 2, 2, 2, 2, 9, 6, 6],
          [9, 3, 2, 2, 2, 2, 8, 9, 6, 6],
          [7, 9, 2, 2, 2, 8, 6, 8, 6, 6],
          [6, 7, 8, 9, 9, 9, 8, 7, 6, 6],
        ])
      end
    end
  end
end

# describe Octopus do
#   subject { described_class.new(6) }
#   context "#increment_and_flash" do
#     context "when below energy level 9" do
#       it "increments its energy level by 1 when below 9 and does not flash" do
#         expect(subject.energy_level).to eq(6)
#         expect(subject.increment_and_flash).to be(nil)
#         expect(subject.energy_level).to eq(7)
#       end
#     end
#
#     context "when at energy level 9" do
#       subject { described_class.new(9) }
#       it "goes to 0 energy level when incremented from 9 and returns one flash" do
#         expect(subject.energy_level).to eq(9)
#         expect(subject.increment_and_flash).to eq(1)
#         expect(subject.energy_level).to eq(0)
#       end
#     end
#   end
# end

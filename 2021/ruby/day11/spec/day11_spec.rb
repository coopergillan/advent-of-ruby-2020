require "day11"

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

  context "answering part 2" do
    it "gets the answer to part2" do
      expect(subject.part2).to eq(195)
    end
  end


  context "#raw_neighbors_coords" do
    context "when checking corners" do
      let(:first) { 0 }
      let(:last) { 9 }

      it "gets the neighboring coordinates" do
        expect(subject.raw_neighbor_coords(first, first)).to eq([[0, 1], [1, 0], [1, 1]])
        expect(subject.raw_neighbor_coords(last, first)).to eq([[8, 0], [8, 1], [9, 1]])
        expect(subject.raw_neighbor_coords(first, last)).to eq([[0, 8], [1, 8], [1, 9]])
        expect(subject.raw_neighbor_coords(last, last)).to eq([[8, 8], [8, 9], [9, 8]])
      end
    end

    context "when checking edge/border pieces" do
      let(:left_or_top) { 0 }
      let(:right_or_bottom) { 9 }

      it "can get the neighboring coordinates" do
        expect(subject.raw_neighbor_coords(2, left_or_top)).to eq([
          [1, 0], [1, 1], [2, 1], [3, 0], [3, 1],
        ])
        expect(subject.raw_neighbor_coords(3, right_or_bottom)).to eq([
          [2, 8], [2, 9], [3, 8], [4, 8], [4, 9],
        ])
        expect(subject.raw_neighbor_coords(left_or_top, 6)).to eq([
          [0, 5], [0, 7], [1, 5], [1, 6], [1, 7],
        ])
        expect(subject.raw_neighbor_coords(right_or_bottom, 3)).to eq([
          [8, 2], [8, 3], [8, 4], [9, 2], [9, 4],
        ])
      end
    end

    context "when checking pieces in the middle" do
      it "can get the neighboring coordinates" do
        expect(subject.raw_neighbor_coords(2, 3)).to eq([
          [1, 2], [1, 3], [1, 4], [2, 2], [2, 4], [3, 2], [3, 3], [3, 4],
        ])
        expect(subject.raw_neighbor_coords(7, 6)).to eq([
          [6, 5], [6, 6], [6, 7], [7, 5], [7, 7], [8, 5], [8, 6], [8, 7],
        ])
      end
    end
  end

  context "#step" do
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

      2.times { subject.step }

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

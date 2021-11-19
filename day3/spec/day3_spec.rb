require "day3"

describe Day3 do
  describe Day3::Terrain do
    subject { described_class.from_file("spec/day3_test_input_small.txt") }

    context "#from_file" do
      it "converts a file path to an array" do
        expect(subject.detail).to match_array([
          "..##.......",
          "#...#...#..",
          ".#....#..#.",
          "..#.#...#.#",
          ".#...##..#.",
        ])
      end
    end
  end

  describe Day3::Part1::Journey do
    subject { described_class.new(3, 1) }

    it "counts trees with a given slope and terrain for simple example" do
      terrain = Day3::Terrain.from_file("spec/day3_test_input_small.txt")
      expect(subject.tree_count(terrain)).to eq(2)
    end

    it "counts trees with a given slope and terrain for bigger example" do
      terrain = Day3::Terrain.from_file("spec/day3_test_input_from_example.txt")
      expect(subject.tree_count(terrain)).to eq(6)
    end
  end
end

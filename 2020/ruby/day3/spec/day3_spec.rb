require "day3"

describe Day3 do
  let(:raw_terrain) { [
    "..##.......",
    "#...#...#..",
    ".#....#..#.",
    "..#.#...#.#",
    ".#...##..#.",
    "..#.##.....",
    ".#.#.#....#",
    ".#........#",
    "#.##...#...",
    "#...##....#",
    ".#..#...#.#",
  ] }
  let(:terrain) { Day3::Terrain.new(raw_terrain) }

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

    it "counts trees with a given slope and terrain for an example terrain" do
      expect(subject.count_trees(terrain)).to eq(7)
    end
  end

  describe Day3::Part2::JourneyLog do
    let(:slopes) { [
      [1, 1],
      [3, 1],
      [1, 2],
    ] }
    subject { described_class.new(slopes, terrain) }

    context "#log_tree_counts" do
      it "counts trees with a given slope and terrain for an example terrain" do
        expect(subject.log_tree_counts).to match_array([2, 7, 2])
      end
    end

    context "#answer_part2" do
      it "gets the product of answer for various slopes" do
        expect(subject.answer_part2).to eq(2 * 7 * 2)
      end
    end
  end
end

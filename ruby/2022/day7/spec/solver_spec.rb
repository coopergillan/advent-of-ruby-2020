require "solver"

describe TopLevelClass do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to the data" do
      expect(subject.input_data[...6]).to match_array([
        ["cd", "/"],
        ["ls"],
        ["dir", "a"],
        [14848514, "b.txt"],
        [8504156, "c.dat"],
        ["dir", "d"],
      ])
    end
  end

  context "#absolute_paths" do
    it "builds array of absolute file paths" do
      expect(subject.absolute_paths).to match_array([
        ["/a/e/i", 584],
        ["/a/f", 29116],
        ["/a/g", 2557],
        ["/b.txt", 14848514],
        ["/c.dat", 8504156],
        ["/a/h.lst", 62596],
        ["/d/j", 4060174],
        ["/d/d.log", 8033020],
        ["/d/d.ext", 5626152],
        ["/d/k", 7214296],
      ])
    end
  end

  context "#directory_sizes" do
    it "builds a hash with each directory's total size" do
      expect(subject.directory_sizes).to include(
        "a" => 94853,
        "e" => 584,
        "d" => 24933642,
        "/" => 48381165,
      )
    end
  end

  context "#solve_part1" do
    it "solves part one" do
      expect(subject.solve_part1).to eq(95437)
    end
  end

  # context "#solve_part2" do
  #   it "solves part two" do
  #     expect(subject.solve_part2).to eq(8)
  #   end
  # end
end

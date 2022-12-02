require "day1"

describe ElfInfo do
  subject { ElfInfo.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to an array" do
      expect(subject.elf_info).to match_array([
        [1000, 2000 ,3000],
        [4000],
        [5000, 6000],
        [7000, 8000, 9000],
        [10000],
      ])
    end
  end

  context "#part1" do
    it "gets the sum of calories for the elf with the most" do
      expect(subject.part1).to eq(24000)  # Taken directly from instructions
    end
  end

  context "#part2" do
    it "gets the sum of the calories for the top three calorie-carrying elves" do
      expect(subject.part2).to eq(45000)  # Taken directly from instructions
    end
  end
end

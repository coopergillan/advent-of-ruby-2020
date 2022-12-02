require "day1"

describe CalorieCounter do
  subject { CalorieCounter.from_file("spec/test_input.txt") }

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

  xcontext "#answer_part1" do
    it "gets the number of increased elevations compared to the previous level" do
      expect(subject.count_increases(1)).to eq(7)  # Taken directly from instructions
    end
  end

  xcontext "#answer_part2" do
    it "gets the number of increased elevations using new 3-part window logic" do
      expect(subject.count_increases(3)).to eq(5)  # Taken directly from instructions
    end
  end
end

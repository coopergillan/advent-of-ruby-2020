require "day1"

describe SonarSweeper do
  subject { SonarSweeper.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to an array" do
      expect(subject.sonar_report).to match_array([
        199, 200, 208, 210, 200, 207, 240, 269, 260, 263,
      ])
    end
  end

  context "#answer_part1" do
    it "gets the number of increased elevations compared to the previous level" do
      expect(subject.answer_part1).to eq(7)  # Taken directly from instructions
    end
  end

  context "#answer_part2" do
    it "gets the number of increased elevations using new 3-part window logic" do
      expect(subject.answer_part2).to eq(5)  # Taken directly from instructions
    end
  end
end

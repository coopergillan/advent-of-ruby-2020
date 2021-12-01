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

  context "#count_increases" do
    it "gets the number of increased elevations compared to the previous level" do
      expect(subject.count_increases).to eq(7) # Taken directly from instructions
    end
  end
end

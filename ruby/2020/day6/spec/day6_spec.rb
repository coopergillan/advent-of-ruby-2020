require "day6"

describe QuestionLog do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "splits the input by blank lines for processing" do
      expect(subject.question_groups).to match_array([
        ["abc"],
        ["a", "b", "c"],
        ["ab", "ac"],
        ["a", "a", "a", "a"],
        ["b"],
      ])
    end
  end

  context "answering part 1" do
    it "counts the distinct questions" do
      expect(subject.part1).to eq(11)
    end
  end

  context "answering part 2" do
    it "counts the questions answered by all in each group" do
      expect(subject.part2).to eq(6)
    end
  end
end

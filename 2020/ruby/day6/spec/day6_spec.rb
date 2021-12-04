require "day6"

describe QuestionLog do
  context "#from_file" do
    subject { described_class.from_file("spec/test_input.txt") }

    it "splits the input by blank lines for processing" do
      expect(subject.question_groups).to match_array([

      ])
    end


  end

  context "answering part 1"
    it "counts the distinct questions"
end

require "day4"

describe Day4 do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to an array" do
      expect(subject.input).to match_array([
        "what will it be?",
      ])
    end
  end

  context "answering part 1" do
    it "hopefully does something soon"
  end
end

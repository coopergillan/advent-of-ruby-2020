require "day13"

describe WrappingPaper do
  subject { described_class.from_file("spec/test_input.txt") }

  context "when input is read" do
    it "gets an array with dimensions of the largest given coordinates" do
      expect(subject.dot_details).to be_a(Array)
      expect(subject.dot_details.first).to eq([6, 10])
      expect(subject.dot_details.last).to eq([9, 0])
    end

    it "gets the fold instructions" do
      expect(subject.fold_instructions).to match_array([
        "fold along y=7", "fold along x=5",
      ])
    end
  end

  context "answering part 1" do
    it "gets the answer to part1" do
      expect(subject.part1).to eq(17)
    end
  end

  context "answering part 2" do
    xit "gets the answer to part2" do
      expect(subject.part2).to eq(195)
    end
  end
end

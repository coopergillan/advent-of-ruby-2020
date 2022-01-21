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

    it "derives the height and width based on given coordinates" do
      expect(subject.height).to eq(15)
      expect(subject.width).to eq(11)
    end

    it "counts the total coordinates" do
      expect(subject.dot_count).to eq(18)
    end
  end

  context "folding the paper" do
    context "#vertical_fold" do
      it "updates the row part of effected coordinates based on fold line" do
        expect(subject.dot_count).to eq(18)
        expect(subject.dot_details).to include(
          [6, 10],
          [0, 14],
          [9, 10],
          [0, 3],
        )

        subject.vertical_fold(7)

        # Folding on row 7 vertically
        # How far  from the fold?
        # 8 goes to 6     # 8 only one from fold - subtract twice that to get 6
        # 10 goes to 4    # 10 is 3 from the fold - subtract twice this to get to four
        # 15 goes to 0    # 15 is 8 from the fold - subtract twice this to get -1 or 0?
        # 13 goes to 1    # 13 is 6 from the fold - subtract twice that to get 1
        # 5 stays the same

        expect(subject.height).to eq(7)
        expect(subject.width).to eq(11)
        # expect(subject.dot_details).to include(
        #   [6, 4],
        #   [0, 14],
        #   [9, 10],
        #   [0, 3],
        # )
      end
    end
  end

  context "answering part 1" do
    it "gets the answer to part1" do
      expect(subject.part1).to eq(17)
    end
  end
end

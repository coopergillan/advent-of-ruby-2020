require "day5"

describe Day5 do
  describe Day5::BoardingPassList do
    subject { described_class.from_file("spec/day5_test_input.txt") }

    context "#from_file" do
      it "reads the list of boarding passes from a raw file" do
        expect(subject.passes).to match_array([
          "FBFBFBFLLR",
          "BBFBFFBLRR",
          "BBBFFFFLLR",
          "FBFFFFFLRL",
          "BFBFFFFLRL",
        ])
      end
    end

    context "#answer_part1"
  end

  describe Day5::Part1::BoardingPass do
    subject { described_class.new("BFFFBBFRRR") }

    it "reads the row and column data correctly" do
      expect(subject).to have_attributes(
        row_data: "BFFFBBF",
        column_data: "RRR",
      )
    end

    it "identifies the row" do
      expect(subject.row).to eq(70)
    end

    it "identifies the column" do
      expect(subject.column).to eq(7)
    end

    context "#read_pass" do
      it "identifies the row and column of the seat" do
        expect(described_class.read_pass).to include(
          row: 10, column: 5,
        )
      end
    end
  end
end

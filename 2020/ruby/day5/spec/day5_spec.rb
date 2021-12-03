require "day5"

describe Day5 do
  describe Day5::BoardingPassList do
    subject { described_class.from_file("spec/test_input.txt") }

    context "#from_file" do
      it "reads the list of boarding passes from a raw file" do
        expect(subject.passes).to match_array([
          "BFFFBBFRRR", # 567
          "FFFBBBFRRR", # 119
          "BBFFBBFRLL", # 820
        ])
      end
    end

    context "#answer_part1"
    it "gets the highest seat_id for a list of boarding passes" do
      expect(subject.answer_part1).to eq(820)
    end
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

    context "#seat_id" do
      it "gets the seat_id per instructions" do
        expect(subject.seat_id).to eq(567)
      end
    end
  end
end

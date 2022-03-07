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

    context "#answer_part1" do
      it "gets the highest seat_id for a list of boarding passes" do
        expect(subject.answer_part1).to eq(820)
      end
    end

    context "answering part 2" do
      let(:seat_map) { [0, 1, 2, 119, 567, 714, 820, 850, 851, 852] }
      it "gets a seats_map with all ids" do
        expect(subject.default_seats_map.first).to eq(0)
        expect(subject.default_seats_map.last).to eq(1023)
      end

      it "removes seat_ids that are found and leaves others" do
        expect(subject.remove_existing_passes(seat_map)).to match_array(
          [0, 1, 2, 714, 850, 851, 852]
        )
      end

      it "finds the only seat_id that does not have a +1 or -1 neighbor" do
        expect(subject.answer_part2(seat_map)).to eq(714)
      end
    end
  end

  describe Day5::BoardingPass do
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

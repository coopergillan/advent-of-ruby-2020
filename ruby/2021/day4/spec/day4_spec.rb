require "day4"

def spot(number, called = false)
  {value: number, called: called}
end

describe BingoGame do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to array of numbers to draw and an array of bingo boards" do
      expect(subject.drawn_numbers).to match_array(
        [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1]
      )
      expect(subject.boards.first.class).to eq(BingoBoard)
      expect(subject.boards.size).to eq(3)
    end
  end

  context "answering part 1" do
    it "draws a number, marks each board while checking for a winner, and gets it" do
      expect(subject.part1).to eq(188 * 24)
    end
  end

  context "answering part 2" do
    it "plays the game again, but gets score for the last winning board" do
      expect(subject.part2).to eq(148 * 13) # 1924
    end
  end
end

describe BingoBoard do
  let(:raw_board) { <<~BINGO
22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19
                    BINGO
  }
  let(:numbers_to_call) { [
    13, 17, 0, 8, 24, 21,  9, 14, 6, 10, 1, 12, 20, 15,
  ] }

  subject { described_class.from_raw(raw_board) }

  context "#new" do
    it "reads in raw strings and converts them to 2x2 array of dicts with value and called boolean" do
      expect(subject.board).to match_array([
        [spot(22), spot(13), spot(17), spot(11), spot(0)],
        [spot(8),  spot(2),  spot(23), spot(4),  spot(24)],
        [spot(21), spot(9),  spot(14), spot(16), spot(7)],
        [spot(6),  spot(10), spot(3),  spot(18), spot(5)],
        [spot(1),  spot(12), spot(20), spot(15), spot(19)],
      ])
      expect(subject.won).to be(false)
    end
  end

  context "#call_number" do
    it "update the called boolean to true when a given number matches a board" do
      [22, 11, 12, 20, 15].each { |number| subject.call_number(number) }

      expect(subject.board.first).to match_array([
        spot(22, true), spot(13), spot(17), spot(11, true), spot(0),
      ])
      expect(subject.board.last).to match_array([
        spot(1), spot(12, true), spot(20, true), spot(15, true), spot(19),
      ])
    end
  end

  context "#uncalled_numbers" do
    context "when nothing has been called" do
      it "returns all numbers" do
        expect(subject.uncalled_numbers).to match_array([
          22, 13,  17, 11,  0,
           8,  2,  23,  4, 24,
          21,  9,  14, 16,  7,
           6, 10,  3, 18,  5,
           1, 12, 20, 15, 19,
        ])
      end
    end

    context "when some numbers have been called" do
      it "returns only the uncalled numbers" do
        [13, 17, 0, 8, 24, 21,  9, 14, 6, 10, 1, 12, 20, 15].each do |number|
          subject.call_number(number)
        end
        expect(subject.uncalled_numbers).to match_array(
          [22, 11, 2, 23, 4, 16, 7, 3, 18, 5, 19],
        )
      end
    end
  end

  context "#check_for_win" do
    let(:first_row) { [22, 13, 17, 11, 0] }
    let(:second_column) { [13, 2, 9, 10, 12] }

    it "returns false if nothing has been called" do
      expect(subject.has_win?).to be(false)
    end

    it "returns true if a row matches" do
      first_row.each { |number| subject.call_number(number) }
      expect(subject.has_win?).to be(true)
    end

    it "returns true if a column matches" do
      second_column.each { |number| subject.call_number(number) }
      expect(subject.has_win?).to be(true)
    end

    it "calculates the final score given a drawn number" do
      numbers_to_call.each { |number| subject.call_number(number) }
      expect(subject.final_score(5)).to eq(130 * 5)
    end
  end
end

require "day4"

describe BingoGame do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to an array" do
      expect(subject.drawn_numbers).to match_array(
        %w{7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1}
      )
    end
  end

  context "answering part 1" do
    it "hopefully does something soon"
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

  subject { described_class.from_raw(raw_board) }

  context "#new" do
    it "reads in raw strings and converts them to 2x2 array of dicts with value and called boolean" do
      expect(subject.board).to match_array([
        [
          {value: 22, called: false},
          {value: 13, called: false},
          {value: 17, called: false},
          {value: 11, called: false},
          {value:  0, called: false},
        ],
        [
          {value:  8, called: false},
          {value:  2, called: false},
          {value: 23, called: false},
          {value:  4, called: false},
          {value: 24, called: false},
        ],
        [
          {value: 21, called: false},
          {value:  9, called: false},
          {value: 14, called: false},
          {value: 16, called: false},
          {value:  7, called: false},
        ],
        [
          {value:  6, called: false},
          {value: 10, called: false},
          {value:  3, called: false},
          {value: 18, called: false},
          {value:  5, called: false},
        ],
        [
          {value:  1, called: false},
          {value: 12, called: false},
          {value: 20, called: false},
          {value: 15, called: false},
          {value: 19, called: false},
        ],
      ])
    end
  end

  context "#call_number" do
    it "update the called boolean to true when a given number matches a board" do
      [22, 11, 12, 20, 15].each do |number|
        subject.call_number(number)
      end
      expect(subject.board.first).to match_array([
          {value: 22, called: true},
          {value: 13, called: false},
          {value: 17, called: false},
          {value: 11, called: true},
          {value:  0, called: false},
        ])
      expect(subject.board.last).to match_array([
          {value:  1, called: false},
          {value: 12, called: true},
          {value: 20, called: true},
          {value: 15, called: true},
          {value: 19, called: false},
      ])
    end
  end

  context "#uncalled_numbers" do
    context "when nthing has been called" do
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
        [13, 17, 0, 8,  24, 21,  9, 14, 6, 10, 1, 12, 20, 15].each do |number|
          subject.call_number(number)
        end
        expect(subject.uncalled_numbers).to match_array(
          [22, 11, 2, 23, 4, 16, 7, 3, 18, 5, 19],
        )
      end
    end
  end

  context "#check_for_win" do
    it "returns false if nothing has been called" do
      expect(subject.has_win?).to be(false)
    end

    it "returns true if a row matches" do
      first_row = [22, 13, 17, 11, 0]
      first_row.each do |number|
        subject.call_number(number)
      end
      expect(subject.has_win?).to be(true)
    end

    it "returns true if a column matches" do
      second_column = [13, 2, 9, 10, 12]
      second_column.each do |number|
        subject.call_number(number)
      end
      expect(subject.has_win?).to be(true)
    end
  end
end

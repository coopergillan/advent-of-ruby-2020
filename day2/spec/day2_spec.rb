require "day2"

describe Day2 do
  describe Day2::PasswordList do
    subject { described_class.from_file("spec/day2_test_input.txt") }

    context "#from_file" do
      it "converts a file path to an array" do
        expect(subject.password_list).to match_array([
          "9-10 b: bbktbbbxhfbpb",
          "2-10 x: xxnxxxwxxsx",
          "5-7 w: ghwwdrr",
          "4-6 z: nzzjzk",
          "7-8 s: szsssswfs",
          "3-8 d: ffdsassp",
        ])
      end
    end

    context "#count_valid_entries" do
      it "counts valid entries for given file using Part1 definition of Entry" do
        expect(subject.count_valid_entries(Day2::Part1::Entry)).to eq(1)
      end

      it "counts valid entries for given file using Part2 definition of Entry" do
        expect(subject.count_valid_entries(Day2::Part2::Entry)).to eq(2)
      end
    end
  end

  describe Day2::Part1::Entry do
    let(:valid_entry ) { "1-4 j: abcdefghijk" }
    subject { Day2::Part1::Entry }

    context "#new" do
      it "instantiates each attribute from raw string" do
        day2_part1_valid = subject.new(valid_entry)

        expect(day2_part1_valid).to have_attributes(
          min_chars: 1,
          max_chars: 4,
          char: "j",
          password: "abcdefghijk",
        )
      end
    end

    context "checking for valid or invalid entries" do
      let(:invalid_entry) { "2-3 j: abcdefghijk" }

      it "identifies a valid password" do
        expect(subject.new(valid_entry).valid?).to be true
      end

      it "identifies an invalid password" do
        expect(subject.new(invalid_entry).valid?).to be false
      end
    end
  end

  describe Day2::Part2::Entry do
    subject { Day2::Part2::Entry }

    context "#new" do
      it "instantiates each attribute from raw string" do
        day2_part2_valid = subject.new("5-6 c: abcdef")
        expect(day2_part2_valid).to have_attributes(
          position1: 5,
          position2: 6,
          char: "c",
          password: "abcdef",
        )
      end
    end

    context "checking for valid or invalid entries" do
      it "identifies a valid password where one position matches" do
        valid_entry = "10-11 j: abcdefghijk"
        expect(subject.new(valid_entry).valid?).to be true
      end

      it "identifies an invalid password when neither position matches" do
        no_matches_entry = "6-8 j: abcdefghijk"
        expect(subject.new(no_matches_entry).valid?).to be false
      end

      it "identifies an invalid password when both positions match" do
        two_matches_entry = "1-3 g: gaggle"
        expect(subject.new(two_matches_entry).valid?).to be false
      end
    end
  end
end

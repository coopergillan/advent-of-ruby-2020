require "day2"

describe Day2 do

  describe "PasswordList" do
    it "converts a file path to an array" do
      day2 = Day2::PasswordList.from_file("spec/day2_test_input.txt")
      expect(day2.password_list).to match_array([
        "9-10 b: bbktbbbxhfbpb",
        "2-10 x: xxnxxxwxxsx",
        "5-7 w: ghwwdrr",
        "4-6 z: nzzjzk",
        "7-8 s: szsssswfs",
      ])
    end
  end

  describe Day2::Entry do
    it "instantiates each attribute from raw string" do
      subject.new("2-3 j: abcdefghijk")

      expect subject.min_chars.to eq(2)
      expect subject.max_chars.to eq(3)
      expect subject.char.to eq("j")
      expect subject.password.to eq("abcdefghijk")
    end
  end
  # context "answer methods" do
  #   subject { Day2.new([2, 3, 4, 5, 7]) }
  #
  #   context "#answer_part1" do
  #     it "returns the product when two numbers equal the given sum" do
  #       expect(subject.answer_part1(8)).to eq(3 * 5)
  #     end
  #
  #     it "returns the product when repeating an element would equal same sum" do
  #       expect(subject.answer_part1(10)).to eq(7 * 3)  # Instead of 5 repeating twice
  #     end
  #
  #     it "returns nil when no combination can be found that equals the sum" do
  #       expect(subject.answer_part1(200)).to be_nil
  #     end
  #   end
  #
  #   context "#answer_part2" do
  #     it "returns the product when three numbers equal the given sum" do
  #       expect(subject.answer_part2(16)).to eq(4 * 5 * 7)
  #     end
  #
  #     it "returns the product when three numbers equal the given sum when two also could" do
  #       expect(subject.answer_part2(9)).to eq(2 * 3 * 4)  # 4 and 5 would make nine, but three numbers are desired
  #     end
  #
  #     it "returns nil when no combination equaling the given sum can be found" do
  #       expect(subject.answer_part1(3141)).to be_nil
  #     end
  #   end
  # end
end

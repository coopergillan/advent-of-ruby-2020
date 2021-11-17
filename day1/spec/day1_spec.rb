require "day1"

describe Day1 do

  it "converts a file path to an array" do
    day1 = Day1.from_file("spec/day1_test_input.txt")
    expect(day1.expense_report).to match_array([21, 32, 10, 40, 55])
  end

  context "answer methods" do
    subject { Day1.new([2, 3, 4, 5, 7]) }

    context "#answer_part1" do
      it "returns the product when two numbers equal the given sum" do
        expect(subject.answer_part1(8)).to eq(3 * 5)
      end

      it "returns the product when repeating an element would equal same sum" do
        expect(subject.answer_part1(10)).to eq(7 * 3)  # Instead of 5 repeating twice
      end

      it "returns nil when no combination can be found that equals the sum" do
        expect(subject.answer_part1(200)).to be_nil
      end
    end

    context "#answer_part2" do
      it "returns the product when three numbers equal the given sum" do
        expect(subject.answer_part2(16)).to eq(4 * 5 * 7)
      end

      it "returns the product when three numbers equal the given sum when two also could" do
        expect(subject.answer_part2(9)).to eq(2 * 3 * 4)  # 4 and 5 would make nine, but three numbers are desired
      end

      it "returns nil when no combination equaling the given sum can be found" do
        expect(subject.answer_part1(3141)).to be_nil
      end
    end
  end
end

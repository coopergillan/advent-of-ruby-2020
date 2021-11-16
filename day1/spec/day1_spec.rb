require "day1"

describe Day1 do
  before(:each) do
    @day1 = Day1.from_file("spec/test_input.txt")
  end

  it "converts a file path to an array" do
    expect(@day1.expense_report).to match_array([21, 32, 10, 40, 55])
  end

  context "#answer_part1" do
    context "when two numbers equal the given sum" do
      it "returns the product" do
        expect(@day1.answer_part1(87)).to eq(32 * 55)
      end

      it "returns the product when repeating an element would equal same sum" do
        expect(@day1.answer_part1(42)).to eq(320)
      end
    end

    context "when no combination can be found that equals the sum" do
      it "returns nil" do
        expect(@day1.answer_part1(200)).to be_nil
      end
    end
  end

  context "#answer_part2" do
    it "returns the product when three numbers equal the given sum" do
      expect(@day1.answer_part2(82)).to eq(32 * 10 * 40)
    end

    it "returns nil when no combination equaling the given sum can be found" do
      expect(@day1.answer_part1(3141)).to be_nil
    end
  end
end

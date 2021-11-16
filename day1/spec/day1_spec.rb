require "day1"

describe Day1 do
  before(:each) do
    @day1 = Day1.from_file("spec/test_input.txt")
  end

  it "converts a file path to an array" do
    expect(@day1.expense_report).to match_array([21, 32, 10, 40, 55])
  end

  context "#calculate_answer" do
    context "when two numbers equal the given sum" do
      it "returns the product" do
        expect(@day1.calculate_answer(87)).to eq(32 * 55)
      end

      it "returns the product when repeating an element would equal same sum" do
        expect(@day1.calculate_answer(42)).to eq(320)
      end
    end

    context "when no combination can be found that equals the sum" do
      it "returns nil" do
        expect(@day1.calculate_answer(200)).to be_nil
      end
    end
  end
end

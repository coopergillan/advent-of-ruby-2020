require "day1"

describe Day1 do
  it "converts a file path to an array" do
    day1 = Day1.from_file("spec/test_input.txt", 1)

    expect(day1.expense_report).to match_array(
      [21, 32, 10, 40, 55],
    )
  end

  context "#find_sum" do
    it "returns two numbers that equal given sum" do
      day1 = Day1.from_file("spec/test_input.txt", 87)
      elements = day1.find_sum_elements
      expect(elements).to match_array([32, 55])
    end

    it "returns nil if no combo is found" do
      day1 = Day1.from_file("spec/test_input.txt", 200)
      elements = day1.find_sum_elements
      expect(elements).to be_nil
    end
  end

  context "#calculate_answer" do
    it "returns the product of two numbers whose sum matches desired sum" do
      day1 = Day1.from_file("spec/test_input.txt", 42)
      expect(day1.calculate_answer).to eq(320)
    end
  end
end

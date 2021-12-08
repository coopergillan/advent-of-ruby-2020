require "day8"

describe SignalCombo do
  context "#new" do
    subject { described_class.from_raw("be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe") }
    it "gets attributes" do
      expect(subject.chars).to match_array([
        "fdgacbe", "cefdb", "cefbgd", "gcbe",
      ])
    end
    it "gets number of chars that represent with 1, 4, 7, or 8" do
      # require "pry"; binding.pry
      expect(subject.unique_chars_count).to eq(2)
    end
  end
end

describe Solver do
  subject { described_class.from_file("spec/test_input.txt") }

  it "gets total count of number of chars with 1, 4, 7, or 8 size" do
    expect(subject.part1).to eq(26)
  end
end

# describe Solver do
# end

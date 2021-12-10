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
      expect(subject.unique_chars_count).to eq(2)
    end
  end
end

describe DigitSignal do
  let (:signals) {
    {
    8 => "acedgfb", # "abcdefg"
    5=> "cdfbe",    # "bcdef"
    2=> "gcdfa",    # "acdfg"
    3=> "fbcad",    # "fbcad"
    7=> "dab",      # "dab"
    9=> "cefabd",   # "cefabd"
    6=> "cdfgeb",   # "cdfgeb"
    4=> "eafb",     # "eafb"
    0=> "cagedb",   # "cagedb"
    1=> "ab",       # "ab"
    }
  }
  context "#decode" do
    it "decodes the simpler, unique combos" do
      expect(described_class.new("ag").decode).to eq(1)
      expect(described_class.new("agf").decode).to eq(7)
      expect(described_class.new("decb").decode).to eq(4)
      expect(described_class.new("acedgfb").decode).to eq(8)
    end

    it "can find shared characters" do
      expect(described_class.new("agf")).to eq(7)
    end
    xit "decodes the combos with other lengths" do
      expect(described_class.new("acdgfb").decode).to eq(0)
      expect(described_class.new("acdgfb").decode).to eq(0)
    end
  end
end

describe SignalCombo do
  subject { described_class.from_raw("acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf") }
  context "#new" do
    it "gets attributes" do
      expect(subject.signal_patterns).to match_array(
        ["acedgfb", "cdfbe", "gcdfa", "fbcad", "dab", "cefabd", "cdfgeb", "eafb", "cagedb", "ab"],
      )
      expect(subject.output_values).to match_array(
        ["cdfeb", "fcadb", "cdfeb", "cdbaf"],
      )
    end
  end

  context "helper methods" do
    it "sorts characters for easier comparison" do
      expect(subject.sort_chars("gabcdef")).to eq("abcdefg")
    end
    it "converts characters into arrays for easier sorting" do
      expect(subject.arrayify("gabcdef")).to match_array([
        "g", "a", "b", "c", "d", "e", "f",
      ])
    end
  end

  context "#build_hash" do
    it "builds a hash for the four unique characters" do
      subject.build_hash
      expect(subject.numbers_hash).to include(
        "cagedb" => 0,
        "ab" => 1,
        "eafb" => 4,
        "cdfgeb" => 6,
        "dab" => 7,
        "acedgfb" => 8,
      )
    end
  end

  context "#unique_chars_count" do
    it "gets number of chars that represent with 1, 4, 7, or 8" do
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

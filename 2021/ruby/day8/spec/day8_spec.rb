require "day8"

describe Solver do
  subject { described_class.from_file("spec/test_input.txt") }
  context "#part1" do
    it "gets the count of 1, 4, 7, and 8 characters in output values" do
      expect(subject.part1).to eq(26)
    end
  end

  context "#part2" do
    it "gets the sum of the decode output values" do
      expect(subject.part2).to eq(61229)
    end
  end
end

describe SignalCombo do
  context "#new" do
    subject { described_class.from_raw("be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe") }

    it "gets attributes" do
      expect(subject.signal_patterns).to match_array([
        "be", "cfbegad", "cbdgef", "fgaecd", "cgeb", "fdcge", "agebfd", "fecdb", "fabcd", "edb",
      ])
      expect(subject.output_values).to match_array([
        "fdgacbe", "cefdb", "cefbgd", "gcbe",
      ])
    end
    it "gets number of chars that represent with 1, 4, 7, or 8" do
      expect(subject.unique_chars_count).to eq(2)
    end

    it "builds the correct numbers hash" do
      subject.build_hash
      expect(subject.numbers_hash).to include(
        "agebfd" => 0,
        "be" => 1,
        "fabcd" => 2,
        "fecdb" => 3,
        "cgeb" => 4,
        "fdcge" => 5,
        "fgaecd" => 6,
        "edb" => 7,
        "cfbegad" => 8,
        "cbdgef" => 9,
      )
    end
  end
end

describe SignalCombo do
  subject { described_class.from_raw(
    "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
  ) }

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
        "gcdfa" => 2,
        "fbcad" => 3,
        "eafb" => 4,
        "cdfbe" => 5,
        "cdfgeb" => 6,
        "dab" => 7,
        "acedgfb" => 8,
        "cefabd" => 9,
      )
    end
  end

  context "answering part 2" do
    it "parses the output into a four-digit number" do
      subject.build_hash
      expect(subject.output_to_number).to eq(5353)
    end
  end
end

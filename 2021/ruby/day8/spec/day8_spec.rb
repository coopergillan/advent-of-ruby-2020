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
  let(:raw_input) {
    "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe"
  }
  subject { described_class.from_raw(raw_input) }
  context "#new" do
    it "gets attributes" do  # Yeah, yeah, not really needed but some assurance was needed =)
      expect(subject.signal_patterns).to match_array([
        "be", "cfbegad", "cbdgef", "fgaecd", "cgeb", "fdcge", "agebfd", "fecdb", "fabcd", "edb",
      ])
      expect(subject.output_values).to match_array([
        "fdgacbe", "cefdb", "cefbgd", "gcbe",
      ])
    end
  end

  context "helper methods" do
    it "converts characters into arrays for easier sorting" do
      expect(subject.arrayify("gabcdef")).to match_array([
        "g", "a", "b", "c", "d", "e", "f",
      ])
    end

    it "gets the intersection of two chars as an array" do
      expect(subject.char_intersection_size("gabcdef", "cg")).to eq(2)
      expect(subject.char_intersection_size("cgfa", "gabcdef")).to eq(4)
    end
  end

  context "it helps answer the main questions" do
    context "when using the original example" do
      it "gets number of chars that represent with 1, 4, 7, or 8" do
        expect(subject.unique_chars_count).to eq(2)
      end

      it "builds the correct numbers hash with first example" do
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

      it "parses the output into a four-digit number for use by #part2" do
        expect(subject.output_to_number).to eq(8394)
      end
    end

    context "when using another given example" do
      context "when answering part 2" do
        let(:raw_input) {
          "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
        }

        it "builds correct numbers hash with another example" do
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

        it "parses the output into a four-digit number for use by #part2" do
          expect(subject.output_to_number).to eq(5353)
        end
      end
    end
  end
end

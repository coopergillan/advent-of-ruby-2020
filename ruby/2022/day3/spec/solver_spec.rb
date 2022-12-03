require "solver"

describe RucksackList do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to the data" do
      expect(subject.input_data).to match_array([
        "vJrwpWtwJgWrhcsFMMfFFhFp",
        "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
        "PmmdzqPrVvPwwTWBwg",
        "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
        "ttgJtRGJQctTZtZT",
        "CrZsJsPPZsGzwwsLwLmpwMDw",
      ])
    end
  end

  context "#solve_part1" do
    it "solves part one" do
      expect(subject.solve_part1).to eq(157)
    end
  end
end

describe Rucksack do
  context "#from_raw" do
    let(:raw_input) { "vJrwpWtwJgWrhcsFMMfFFhFp" }
    subject { described_class.from_raw(raw_input) }

    it "translates the raw input into the compartments" do
      expect(subject.compartment1).to eq("vJrwpWtwJgWr")
      expect(subject.compartment2).to eq("hcsFMMfFFhFp")
    end

    it "finds the common element in the two compartments" do
      expect(subject.common_element).to eq("p")
    end

    it "finds the priority for the common element (a-z 1-26, A-Z 27-52)" do
      expect(subject.priority).to eq(16)
    end
  end
end

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

  context "#solve_part2" do
    it "solves part two" do
      expect(subject.solve_part2).to eq(70)
    end
  end
end

describe Rucksack do
  context "#from_raw" do
    let(:raw_input) { "vJrwpWtwJgWrhcsFMMfFFhFp" }
    subject { described_class.new(raw_input) }

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

describe RucksackGroup do
  let(:rucksack1) { Rucksack.new("vJrwpWtwJgWrhcsFMMfFFhFp") }
  let(:rucksack2) { Rucksack.new("jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL") }
  let(:rucksack3) { Rucksack.new("PmmdzqPrVvPwwTWBwg") }

  subject { described_class.new([rucksack1, rucksack2, rucksack3]) }

  it "finds the common element across all three rucksacks" do
    expect(subject.common_element).to eq("r")
  end

  it "finds the priority for the common element (a-z 1-26, A-Z 27-52)" do
    expect(subject.priority).to eq(18)
  end
end

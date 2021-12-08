require "day7"

describe LuggageCheck do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "creates the class with the correct attributes" do
      expect(subject.luggage).to match_array([
        "what", "will", "it", "be?",
      ])
    end
  end

  context "answering part 1" do
    it "counts the number of bags that could contain a shiny gold bag" do
      expect(subject.part1).to eq(4)
    end
  end

  context "answering part 2"

end

describe LuggageRule do
  context "#from_raw" do
    let(:raw_input_with_bags) do
      "dark orange bags contain 3 bright white bags, 4 muted yellow bags."
    end
    subject { described_class.from_raw(raw_input_with_bags) }
    it "instantiates from the raw strings given in input file" do
      expect(subject).to have_attributes(
        item_name: "dark orange",
        capacity: {"bright white" => 3, "muted yellow" => 4 },
      )
    end
  end

  # context "#new" do
  # let(:description) { "muted yellow" }
  # let(:capacity) { {"shiny gold" => 2, "faded blue" => 9 }
  # subject { described_class.new(description, capacity) }
  #   it "instantiates with only the helpful and necessary attributes" do
  #     expect(subject).to have_attributes(
  #       description: "muted yellow",
  #       capacity: {"shiny gold" => 2, "faded blue" => 9 },
  #     )
  #   end
  # end
end

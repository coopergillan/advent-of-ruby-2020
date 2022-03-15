require "day7"
  # subject { described_class.from_file("spec/test_input.txt") }

describe BagInfo do
  context "#from_raw" do
    it "creates instances with no capacity" do
      bag_info = described_class.from_raw(
        "dotted black bags contain no other bags.",
      )
      expect(bag_info.type).to eq("dotted black")
      expect(bag_info.capacity).to eq({})
    end

  context "#parse_capacity" do
    let(:raw_input) { "dotted black bags contain no other bags" }
    subject { described_class.from_raw(raw_input) }

    it "can convert bags with no capacity to an empty hash" do
      expect(subject.parse_capacity("no other bags")).to eq({})
    end

    it "can convert bags with one capacity specification into a one-element hash" do
      expect(subject.parse_capacity("1 shiny gold bag")).to eq({"shiny gold" => 1})
    end

    it "can convert bags with two capacity specifications into a two-element hash" do
      expect(subject.parse_capacity("3 faded blue bags, 4 dotted black bags")).to include(
        {"faded blue" => 3, "dotted black" => 4},
      )
    end
  end

  #   it "creates instances with a capacity of one type of bag" do
  #     bag_description = described_class.from_raw(
  #       "bright white bags contain 1 shiny gold bag.",
  #     )
  #     expect(bag_description.details).to include(
  #       {"bright white" => {"shiny gold" => 1}},
  #     )
  #   end
  #
  #   it "creates instances with a capacity of two types of bags" do
  #     bag_description = described_class.from_raw(
  #       "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
  #     )
  #     expect(bag_description.details).to include({
  #       "dark orange" => {"bright white" => 3, "muted yellow" => 4}
  #     })
  #   end

  end
end

#   context "answering part 1" do
#     it "counts the distinct questions" do
#       expect(subject.part1).to eq(11)
#     end
#   end
#
#   context "answering part 2" do
#     it "counts the questions answered by all in each group" do
#       expect(subject.part2).to eq(6)
#     end
#   end
# end

require "day7"
  # subject { described_class.from_file("spec/test_input.txt") }

describe BagDescription do
  context "#from_raw" do
    it "creates instances with no capacity" do
      bag_description = described_class.from_raw(
        "dotted black bags contain no other bags.",
      )
      expect(bag_description.details).to include(
        {"dotted black" => nil},
      )
    end

    it "creates instances with a capacity of one type of bag" do
      bag_description = described_class.from_raw(
        "bright white bags contain 1 shiny gold bag.",
      )
      expect(bag_description.details).to include(
        {"bright white" => {"shiny gold" => 1}},
      )
    end

    it "creates instances with a capacity of two types of bags" do
      bag_description = described_class.from_raw(
        "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
      )
      expect(bag_description.details).to include({
        "dark orange" => {"bright white" => 3, "muted yellow" => 4}
      })
    end
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

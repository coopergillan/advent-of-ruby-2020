require "day12"

describe CaveMap do
  subject { described_class.from_file("spec/test_input.txt") }

  context "when map is created" do
    it "builds a hash of connections" do
      expect(subject.connections).to include(
        "start" => ["A", "b"],
        "A" => ["c", "b", "end"],
        "b" => ["A", "d", "end"],
        "c" => ["A"],
        "d" => ["b"],
      )
    end
  end

  context "answering part 1" do
    it "gets the count of paths to answer part1" do
      expect(subject.part1).to eq(10)
    end
  end

  # context "answering part 2" do
  #   it "gets the answer to part2" do
  #     expect(subject.part2).to eq(195)
  #   end
  # end
end


# describe CaveConnection do
#   subject { described_class.new("A-c") }
#
#   context "#new" do
#     it "creates a hash with the two connections" do
#       expect(subject.connections).to include(
#         "A" => ["c"],
#         "c" => ["A"],
#     end
#   end
# end
#
# describe Cave do
# end

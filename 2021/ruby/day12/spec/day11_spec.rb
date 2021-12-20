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

  context "#build_paths" do

    let(:paths_hash) { {"start" => ["end"]} }
    subject { described_class.new(paths_hash) }

    context "when trying simpler examples" do
      context "the simplest example" do
        it "constructs each possible path" do
          expect(subject.build_paths).to match_array([
            ["start", "end"],
          ])
        end
      end

      context "still simple example" do
        let(:paths_hash) { {"start" => ["A"], "A" => ["end"]} }
        it "constructs each possible path" do
          expect(subject.build_paths).to match_array([
            ["start", "A", "end"],
          ])
        end
      end

      context "another example" do
        let(:paths_hash) {
          {
            "start" => ["A", "b"],
            "A" => ["b", "end"],
            "b" => ["A", "end"],
          }
        }
        it "constructs each possible path" do
          expect(subject.build_paths).to match_array([
            ["start", "A", "end"],
            ["start", "b", "end"],
            ["start", "A", "b", "end"],
            ["start", "A", "b", "A", "end"],
            ["start", "b", "A", "end"],
          ])
        end
      end
    end

    context "when running with a larger example" do
      let(:paths_hash) {
        {
        "start" => ["A", "b"],
        "A" => ["c", "b", "end"],
        "b" => ["A", "d", "end"],
        "c" => ["A"],
        "d" => ["b"],
        }
      }
     xit "constructs each possible path" do
        expect(subject.build_paths).to match_array([
          ["start", "A", "b", "A", "c", "A", "end"],
          ["start", "A", "b", "A", "end"],
          ["start", "A", "b", "end"],
          ["start", "A", "c", "A","b", "A", "end"],
          ["start", "A", "c", "A","b", "end"],
          ["start", "A", "c", "A","end"],
          ["start", "A", "end"],
          ["start", "b", "A", "c", "A", "end"],
          ["start", "b", "A", "end"],
          ["start", "b", "end"],
        ])
      end
    end
  end

  context "#part1" do
    xit "gets the count of paths to answer part1" do
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

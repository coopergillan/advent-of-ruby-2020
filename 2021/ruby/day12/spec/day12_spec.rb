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

  context "when a larger map is created" do
    subject { described_class.from_file("spec/test_input_larger.txt") }
    it "builds a hash of connections" do
      expect(subject.connections).to include(
        "dc" => ["end", "HN", "LN", "kj"],
        "start" => ["HN", "kj", "dc"],
        "kj" => ["sa", "HN", "dc"],
        "HN" => ["dc", "end", "kj"],
        "LN" => ["dc"],
        "sa" => ["kj"],
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

    context "when running with a slightly larger example" do
      let(:paths_hash) {
        {
        "start" => ["A", "b"],
        "A" => ["c", "b", "end"],
        "b" => ["A", "d", "end"],
        "c" => ["A"],
        "d" => ["b"],
        }
      }
      it "constructs each possible path" do
        # asdf = subject.build_paths
        # expect(asdf.size).to eq(10)
        expect(subject.build_paths).to match_array([
          ["start", "A", "b", "A", "c", "A", "end"],
          ["start", "A", "b", "A", "end"],
          ["start", "A", "b", "end"],
          ["start", "A", "c", "A", "b", "A", "end"],
          ["start", "A", "c", "A", "b", "end"],
          ["start", "A", "c", "A","end"],
          ["start", "A", "end"],
          ["start", "b", "A", "c", "A", "end"],
          ["start", "b", "A", "end"],
          ["start", "b", "end"],
        ])
      end
    end

    context "when running with an even larger example" do
      let(:paths_hash) {
				{
          # "dc" => ["HN", "LN", "kj", "end"],
					"dc" => ["end", "HN", "LN", "kj"],
					"start" => ["HN", "kj", "dc"],
					# "HN" => ["dc", "kj", "end"],
					"HN" => ["dc", "end", "kj"],
					"LN" => ["dc"],
					"kj" => ["sa", "HN", "dc"],
					"sa" => ["kj"]
				}
      }
      it "constructs each possible path" do
        # asdf = subject.build_paths
				# require "pry"; binding.pry
        # expect(asdf.size).to eq(19)
        expect(subject.build_paths).to match_array([
					["start", "HN", "dc", "HN", "end"],      # got it
					["start", "HN", "dc", "HN", "kj", "HN", "end"],           ### NEED TO GET BACK TO HN AT THE END
					["start", "HN", "dc", "end"],      # got it
					["start", "HN", "dc", "kj", "HN", "end"],           ### NEED TO GET BACK TO HN AT THE END
					["start", "HN", "end"],      # got it
					["start", "HN", "kj", "HN", "dc", "HN", "end"],           ### NEED TO GET BACK TO HN AT THE END
					["start", "HN", "kj", "HN", "dc", "end"],      # got it
					["start", "HN", "kj", "HN", "end"],      # got it
					["start", "HN", "kj", "dc", "HN", "end"],           ### NEED TO GET BACK TO HN AT THE END
					["start", "HN", "kj", "dc", "end"],      # got it
					["start", "dc", "HN", "end"],      # got it
					["start", "dc", "HN", "kj", "HN", "end"],           ### NEED TO GET BACK TO HN AT THE END
					["start", "dc", "end"],      # got it
					["start", "dc", "kj", "HN", "end"],           ### NEED TO GET BACK TO HN AT THE END
					["start", "kj", "HN", "dc", "HN", "end"],      # got it
					["start", "kj", "HN", "dc", "end"],      # got it
					["start", "kj", "HN", "end"],      # got it
					["start", "kj", "dc", "HN", "end"],
					["start", "kj", "dc", "end"],
				])
      end
    end
  end

  context "#part1" do
    context "when trying the smaller example" do
      it "gets the count of paths to answer part1" do
        expect(subject.part1).to eq(10)
      end
    end

    context "when trying the next larger example" do
      subject { described_class.from_file("spec/test_input_larger.txt") }

      it "gets the count of paths to answer part1" do
        asdf = subject.build_paths
        require "pry"; binding.pry
        expect(subject.part1).to eq(19)
      end
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

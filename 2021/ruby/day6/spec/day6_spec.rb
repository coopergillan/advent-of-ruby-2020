require "day6"

describe FishPopulation do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "creates array of fish days" do
      expect(subject.fish_population).to match_array([3,4,3,1,2])
    end
  end

  context "answering part 1" do
    let(:start_population) { [3,4,3,1,2] }
    subject { described_class.new(start_population) }
    context "#simulate_day" do

      it "decrements day for each fish after one day" do
        subject.simulate_day
        expect(subject.fish_population).to match_array([2,3,2,0,1])
      end

      it "decrements again and spawns new fish after two days" do
        2.times { subject.simulate_day }
        expect(subject.fish_population).to match_array([1, 2, 1, 6, 0, 8])
      end

      it "handles changes for all 18 days" do
        18.times { subject.simulate_day }
        expect(subject.fish_population).to match_array([
          6,0,6,4,5,6,0,1,1,2,6,0,1,1,1,2,2,3,3,4,6,7,8,8,8,8,
        ])
      end
    end
    context "#part1" do
      it "counts the fish population after 18 days" do
        days_to_simulate = 18
        expect(subject.part1(18)).to eq(26)
      end

      it "counts the fish population after 80 days" do
        expect(subject.part1).to eq(5934)
      end
    end
  end

  context "answering part 2"

end

# describe VentLine do
#   subject { described_class.new(x1, y1, x2, y2) }
#   context "#coordinates" do
#     context "when the x coordinates match and make a vertical line" do
#       let(:x1) { 1 }
#       let(:y1) { 1 }
#       let(:x2) { 1 }
#       let(:y2) { 3 }
#       it "gets each coordinate to be plotted with x the same and y incremental" do
#         expect(subject.coordinates).to match_array([
#           [1, 1], [1, 2], [1, 3],
#         ])
#       end
#     end
#
#     context "when the y coordinates match and make a horizontal line" do
#       let(:x1) { 2 }
#       let(:y1) { 5 }
#       let(:x2) { 6 }
#       let(:y2) { 5 }
#       it "gets each coordinate to be plotted with x the same and y incremental" do
#         expect(subject.coordinates).to match_array([
#           [2, 5], [3, 5], [4, 5], [5, 5], [6, 5],
#         ])
#       end
#     end
#
#     context "when the x and y coordinates do not match for a diagonal line" do
#       context "when parsing a SW/NE diagonal" do
#       let(:x1) { 9 }
#       let(:y1) { 7 }
#       let(:x2) { 7 }
#       let(:y2) { 9 }
#       it "gets each coordinate to be plotted with x the same and y incremental" do
#         expect(subject.coordinates(check_diagonals: true)).to match_array([
#           [9,7], [8, 8], [7, 9],
#         ])
#       end
#     end
#       context "when parsing a NW/SE diagonal" do
#         let(:x1) { 1 }
#         let(:y1) { 1 }
#         let(:x2) { 3 }
#         let(:y2) { 3 }
#         it "gets each coordinate to be plotted" do
#           expect(subject.coordinates(check_diagonals: true)).to match_array([
#             [1, 1], [2, 2], [3, 3],
#           ])
#         end
#         it "gets each coordinate to be plotted" do
#           expect(subject.coordinates(check_diagonals: true)).to match_array([
#             [1, 1], [2, 2], [3, 3],
#           ])
#         end
#       end
#     end
#   end
# end

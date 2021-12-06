require "day6"

describe FishPopulation do
  context "#from_file" do
    subject { described_class.from_file("spec/test_input.txt") }

    it "creates array of fish days" do
      expect(subject.fish_population).to include({
        0 => 0,
        1 => 1,
        2 => 1,
        3 => 2,
        4 => 1,
        5 => 0,
        6 => 0,
        7 => 0,
        8 => 0,
      })
    end
  end

  context "answering each part" do
    let(:start_population) { [3, 4, 3, 1, 2] }
    subject { described_class.new(start_population) }

    context "answering part 1" do
      context "#simulate_day" do

        it "updates counts for each fish after one day" do
          subject.simulate_day
          expect(subject.fish_population).to include({
            0 => 1,
            1 => 1,
            2 => 2,
            3 => 1,
            4 => 0,
            5 => 0,
            6 => 0,
            7 => 0,
            8 => 0,
          })
        end

        it "updates counts for each fish after two days" do
          2.times { subject.simulate_day }
          expect(subject.fish_population).to include({
            0 => 1,
            1 => 2,
            2 => 1,
            3 => 0,
            4 => 0,
            5 => 0,
            6 => 1,
            7 => 0,
            8 => 1,
          })
        end

        it "handles changes for all 11 days" do
          11.times { subject.simulate_day }
          expect(subject.fish_population).to include({
            0 => 2,
            1 => 2,
            2 => 1,
            3 => 0,
            4 => 1,
            5 => 1,
            6 => 4,
            7 => 1,
            8 => 3,
          })
        end

        it "handles changes for all 18 days" do
          18.times { subject.simulate_day }
          expect(subject.fish_population).to include({
            0 => 3,
            1 => 5,
            2 => 3,
            3 => 2,
            4 => 2,
            5 => 1,
            6 => 5,
            7 => 1,
            8 => 4,
          })
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

      context "#part2" do
        it "counts the fish population after 256 days" do
          expect(subject.part2).to eq(26984457539)
        end

        it "counts the fish population after 80 days" do
          expect(subject.part1).to eq(5934)
        end
      end
    end
  end
#   context "answering each part" do
#     let(:start_population) { [3,4,3,1,2] }
#     subject { described_class.new(start_population) }
#
#     context "answering part 1" do
#       context "#simulate_day" do
#
#         it "decrements day for each fish after one day" do
#           subject.simulate_day
#           expect(subject.fish_population).to match_array([2,3,2,0,1])
#         end
#
#         it "decrements again and spawns new fish after two days" do
#           2.times { subject.simulate_day }
#           expect(subject.fish_population).to match_array([1, 2, 1, 6, 0, 8])
#         end
#
#         it "handles changes for all 18 days" do
#           18.times { subject.simulate_day }
#           expect(subject.fish_population).to match_array([
#             6,0,6,4,5,6,0,1,1,2,6,0,1,1,1,2,2,3,3,4,6,7,8,8,8,8,
#           ])
#         end
#       end
#       context "#part1" do
#         it "counts the fish population after 18 days" do
#           days_to_simulate = 18
#           expect(subject.part1(18)).to eq(26)
#         end
#
#         it "counts the fish population after 80 days" do
#           expect(subject.part1).to eq(5934)
#         end
#       end
#
#       context "#part1_better_hopefully" do
#         it "counts the fish population after 18 days" do
#           days_to_simulate = 18
#           expect(subject.part1_better_hopefully(days_to_simulate)).to eq(26)
#         end
#
#         it "counts the fish population after 80 days" do
#           days_to_simulate = 80
#           expect(subject.part1_better_hopefully(days_to_simulate)).to eq(5934)
#         end
#       end
#     end
#
#     context "answering part 2" do
#       it "counts the fish population after 256 days" do
#         expect(subject.part2).to eq(26984457539)
#       end
#     end
#   end
# end
#
# describe "Stuff" do
#   it "gets the correct empty hash" do
#     expect(figure_it_out).to include({
#       0 => 0,
#       1 => 0,
#       2 => 0,
#       3 => 0,
#       4 => 0,
#       5 => 0,
#       6 => 0,
#       7 => 0,
#       8 => 0,
#     })
#   end
#   # it "simulates population simply" do
#   #   expect(simulate(
#   #     [0,1,0,5,6,0,1,2,2,3,0,1,2,2,2,3,3,4,4,5,7,8], 1
#   #   )).to eq(
#   #     [6,0,6,4,5,6,0,1,1,2,6,0,1,1,1,2,2,3,3,4,6,7,8,8,8,8]
#   #   )
#   # end
#   #
#   # it "ret8urns poopulation if xzero days given" do
#   #   expect(simulate([3,4,3,1,2], 0)).to match_array([3,4,3,1,2])
#   # end
#   #
#   # it "simulates another population" do
#   #   expect(simulate([3,4,3,1,2], 2)).to match_array([1, 2, 1, 6, 0, 8])
#   # end
#   #
#   # it "returns poopulation if xzero days given" do
#   #   expect(simulate([3,4,3,1,2], 1)).to match_array([2,3,2,0,1])
#   # end
#   #
#   # it "returns poopulation if 18 days given" do
#   #   expect(
#   #   expect(simulate([3,4,3,1,2], 18)).to match_array([2,3,2,0,1])
#   # end
end

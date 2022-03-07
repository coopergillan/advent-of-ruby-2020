require "day6"

describe School do
  context "#from_file" do
    subject { described_class.from_file("spec/test_input.txt") }

    it "creates array of fish days" do
      expect(subject.population).to include({
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

    context "#simulate_day" do
      it "updates counts for each fish after one day" do
        subject.simulate_day
        expect(subject.population).to include({
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

      it "updates counts for two days, including spawning a new one" do
        2.times { subject.simulate_day }
        expect(subject.population).to include({
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

      it "handles changes for all 18 days" do
        18.times { subject.simulate_day }
        expect(subject.population).to include({
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
      it "counts the population after 18 days" do
        days_to_simulate = 18
        expect(subject.part1(18)).to eq(26)
      end

      it "counts the population after 80 days" do
        expect(subject.part1).to eq(5934)
      end
    end

    context "#part2" do
      it "counts the fish population after 256 days" do
        expect(subject.part2).to eq(26984457539)
      end
    end
  end
end

require "solver"

describe RockPaperScissorsGame do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to the data" do
      expect(subject.input_data).to match_array([
        ["A", "Y"],
        ["B", "X"],
        ["C", "Z"],
      ])
    end
  end

  context "#solve_part1" do
  it "solves part one" do
    expect(subject.solve_part1).to eq(15)
  end
  end
end

describe Round do
  context "#from_raw" do
    let(:raw_input_array) { ["A", "Z"] }
    subject { described_class.from_raw(raw_input_array) }
    it "translates the raw input to the shapes - maybe this is better?" do
      expect(subject.opponent_shape).to eq(:rock)
      expect(subject.self_shape).to eq(:scissors)
    end
  end

  context "#decide_round" do
    subject { described_class.new(opponent_shape, self_shape) }
    let(:self_shape) { :placeholder }

    context "when the opponent plays rock" do
      let(:opponent_shape) { :rock }

      context "when self plays paper" do
        let(:self_shape) { :paper }
        it "gets the score for self winning" do
          expect(subject.self_score).to eq(2 + 6)
        end
      end

      context "when self plays rock" do
        let(:self_shape) { :rock }
        it "gets score for a draw" do
          expect(subject.self_score).to eq(1 + 3)
        end
      end

      context "when self plays scissors" do
        let(:self_shape) { :scissors }
        it "gets score for self losing" do
          expect(subject.self_score).to eq(3 + 0)
        end
      end
    end

    context "when the opponent plays paper" do
      let(:opponent_shape) { :paper }

      context "when self plays paper" do
        let(:self_shape) { :paper }
        it "gets the score for a draw" do
          expect(subject.self_score).to eq(2 + 3)
        end
      end

      context "when self plays rock" do
        let(:self_shape) { :rock }
        it "gets score for a loss" do
          expect(subject.self_score).to eq(1 + 0)
        end
      end

      context "when self plays scissors" do
        let(:self_shape) { :scissors }
        it "gets score for self winning" do
          expect(subject.self_score).to eq(6 + 3)
        end
      end
    end

    context "when the opponent plays scissors" do
      let(:opponent_shape) { :scissors }

      context "when self plays paper" do
        let(:self_shape) { :paper }
        it "gets the score for a loss" do
          expect(subject.self_score).to eq(2 + 0)
        end
      end

      context "when self plays rock" do
        let(:self_shape) { :rock }
        it "gets score for a win" do
          expect(subject.self_score).to eq(1 + 6)
        end
      end

      context "when self plays scissors" do
        let(:self_shape) { :scissors }
        it "gets score for a draw" do
          expect(subject.self_score).to eq(3 + 3)
        end
      end
    end
  end
end

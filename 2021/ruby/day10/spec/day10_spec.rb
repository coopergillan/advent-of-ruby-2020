require "day10"

describe SyntaxChecker do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#part1" do
    it "scores each corrupted line and ignores uncorrupted ones" do
      expect(subject.part1).to eq(26397)
    end
  end

  # context "#part2" do
  #   it "gets the sum of the decode output values" do
  #     expect(subject.part2).to eq(61229)
  #   end
  # end
end


describe SyntaxLine do

  context "part1" do
    context "when parsing a legal line"
    let(:legal_line) { "[({(<(())[]>[[{[]{<()<>>" }
    subject { described_class.new(legal_line) }

    it "returns nil" do
      expect(subject.parse).to be(nil)
    end

    context "when parsing a corrupted line" do
      let(:corrupted_line1) { "{([(<{}[<>[]}>{[]{[(<()>" }
      let(:corrupted_line2) { "[[<[([]))<([[{}[[()]]]" }
      let(:corrupted_line3) { "[{[{({}]{}}([{[{{{}}([]" }
      let(:corrupted_line4) { "[<(<(<(<{}))><([]([]()" }
      let(:corrupted_line5) { "<{([([[(<>()){}]>(<<{{" }

      it "returns the first illegal character" do
        expect(described_class.new(corrupted_line1).parse).to eq("}")
        expect(described_class.new(corrupted_line2).parse).to eq(")")
        expect(described_class.new(corrupted_line3).parse).to eq("]")
        expect(described_class.new(corrupted_line4).parse).to eq(")")
        expect(described_class.new(corrupted_line5).parse).to eq(">")
      end

      it "assigns the correct points" do
        expect(described_class.new(corrupted_line1).score).to eq(1197)
        expect(described_class.new(corrupted_line2).score).to eq(3)
        expect(described_class.new(corrupted_line3).score).to eq(57)
        expect(described_class.new(corrupted_line4).score).to eq(3)
        expect(described_class.new(corrupted_line5).score).to eq(25137)
        expect(described_class.new(legal_line).score).to eq(0)
      end
    end
  end
end

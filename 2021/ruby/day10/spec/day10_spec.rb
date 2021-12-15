require "day10"

describe SyntaxChecker do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#part1" do
    it "scores each corrupted line and ignores uncorrupted ones" do
      expect(subject.part1).to eq(26397)
    end
  end

  context "#part2" do
    it "scores each incomplete line according to completing characters" do
      expect(subject.part2).to eq(288957)
    end
  end
end


describe SyntaxLine do
  let(:legal_line1) { "[({(<(())[]>[[{[]{<()<>>" }

  context "part 1" do
    context "when parsing corrupted lines" do
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
      end
    end
  end

  context "part 2" do

    context "when parsing incomplete lines" do
      let(:legal_lines) { [
        ["[({(<(())[]>[[{[]{<()<>>", "}}]])})]"],
        ["[(()[<>])]({[<{<<[]>>(", ")}>]})"],
        ["(((({<>}<{<{<>}{[]{[]{}", "}}>}>))))"],
        ["{<[[]]>}<{[{[{[]{()[[[]", "]]}}]}]}>"],
        ["<{([{{}}[<[[[<>{}]]]>[]]", "])}>"],
      ] }
      let(:corrupted_line1) { "{([(<{}[<>[]}>{[]{[(<()>" }

      it "gets the closing characters needed to complete the line" do
        legal_lines.each do |chars, exp|
          expect(described_class.new(chars).complete_line).to eq(exp)
        end
      end

      it "handles corrupted lines" do
        expect(described_class.new(corrupted_line1).complete_line).to be(nil)
      end

      let(:legal_lines_points) { [
        ["[({(<(())[]>[[{[]{<()<>>", 288957],
        ["[(()[<>])]({[<{<<[]>>(", 5566],
        ["(((({<>}<{<{<>}{[]{[]{}", 1480781],
        ["{<[[]]>}<{[{[{[]{()[[[]", 995444],
        ["<{([{{}}[<[[[<>{}]]]>[]]", 294],
      ] }
      it "assigns the correct points" do
        legal_lines_points.each do |chars, exp_points|
          expect(described_class.new(chars).part2_score).to eq(exp_points)
        end
      end
    end
  end
end

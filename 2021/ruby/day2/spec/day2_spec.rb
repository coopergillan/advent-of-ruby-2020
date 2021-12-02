require "day2"

describe Submarine do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to an array" do
      expect(subject.instructions).to match_array([
        "forward 5",
        "down 5",
        "forward 8",
        "up 3",
        "down 8",
        "forward 2",
      ])
      expect(subject.horizontal_position).to eq(0)
      expect(subject.depth).to eq(0)
    end
  end

  context "#navigate" do
    it "increases horizontal position when given a forward command" do
      subject.navigate("forward 7")
      expect(subject.horizontal_position).to eq(7)
      expect(subject.depth).to eq(0)
    end

    it "increases depth when given a down command" do
      subject.navigate("down 6")
      expect(subject.horizontal_position).to eq(0)
      expect(subject.depth).to eq(6)
    end

    it "decreases depth when given an up command" do
      subject.navigate("down 6")
      subject.navigate("up 2")
      expect(subject.horizontal_position).to eq(0)
      expect(subject.depth).to eq(4)
    end
  end

  context "#answer_part1" do
    it "gets the product of horizontal position and depth" do
      expect(subject.answer_part1).to eq(15 * 10)
      expect(subject.horizontal_position).to eq(15)
      expect(subject.depth).to eq(10)
    end
  end
end

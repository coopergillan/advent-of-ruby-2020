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
      expect(subject.aim).to eq(0)
    end
  end

  context "#navigate_part1" do
    it "increases horizontal position when given a forward command" do
      subject.navigate_part1("forward 7")
      expect(subject.horizontal_position).to eq(7)
      expect(subject.depth).to eq(0)
      expect(subject.aim).to eq(0)
    end

    it "increases depth when given a down command" do
      subject.navigate_part1("down 6")
      expect(subject.horizontal_position).to eq(0)
      expect(subject.depth).to eq(6)
      expect(subject.aim).to eq(0)
    end

    it "decreases depth when given an up command" do
      subject.navigate_part1("down 6")
      subject.navigate_part1("up 2")
      expect(subject.horizontal_position).to eq(0)
      expect(subject.depth).to eq(4)
      expect(subject.aim).to eq(0)
    end
  end

  context "#answer_part1" do
    it "gets the product of horizontal position and depth" do
      expect(subject.answer_part1).to eq(15 * 10)
      expect(subject.horizontal_position).to eq(15)
      expect(subject.depth).to eq(10)
    end
  end

  context "#navigate_part2" do
    context "when given a down command" do
      it "increases aim by the given amount" do
        subject.navigate_part2("down 5")
        expect(subject.aim).to eq(5)
        expect(subject.horizontal_position).to eq(0)
        expect(subject.depth).to eq(0)
      end
    end

    context "when given an up command" do
      it "decreases aim by the given amount" do
        subject.navigate_part2("down 5")
        subject.navigate_part2("up 2")
        expect(subject.aim).to eq(3)
        expect(subject.horizontal_position).to eq(0)
        expect(subject.depth).to eq(0)
      end
    end

    context "when given set of commands include forward" do
      it "increases horizontal position and leaves aim unchanged at start" do
        subject.navigate_part2("forward 3")
        expect(subject.horizontal_position).to eq(3)
        expect(subject.depth).to eq(0)
        expect(subject.aim).to eq(0)
      end

      it "increases horizontal position and increases depth based on aim" do
        subject.navigate_part2("forward 3")
        subject.navigate_part2("down 5")
        subject.navigate_part2("forward 6")
        expect(subject.horizontal_position).to eq(9)
        expect(subject.depth).to eq(30)
        expect(subject.aim).to eq(5)
      end

      it "updates position, depth, and aim, according to the part 2 rules" do
        subject.navigate_part2("forward 5")
        expect(subject.horizontal_position).to eq(5)
        expect(subject.depth).to eq(0)
        expect(subject.aim).to eq(0)

        subject.navigate_part2("down 5")
        expect(subject.horizontal_position).to eq(5)
        expect(subject.depth).to eq(0)
        expect(subject.aim).to eq(5)

        subject.navigate_part2("forward 8")
        expect(subject.horizontal_position).to eq(13)
        expect(subject.depth).to eq(40)
        expect(subject.aim).to eq(5)

        subject.navigate_part2("up 3")
        expect(subject.horizontal_position).to eq(13)
        expect(subject.depth).to eq(40)
        expect(subject.aim).to eq(2)
      end
    end

  end

  context "#answer_part2" do
    it "gets the product of horizontal position and depth" do
      expect(subject.answer_part2).to eq(15 * 60)
      expect(subject.horizontal_position).to eq(15)
      expect(subject.depth).to eq(60)
      expect(subject.aim).to eq(10)
    end
  end
end

require "solver"

describe TopLevelClass do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to the data" do
      expect(subject.input_data).to match_array([
        [3, 0, 3, 7, 3],
        [2, 5, 5, 1, 2],
        [6, 5, 3, 3, 2],
        [3, 3, 5, 4, 9],
        [3, 5, 3, 9, 0],
      ])
      expect(subject.height).to eq(5)
      expect(subject.width).to eq(5)
    end
  end

  context "#tree_visible?" do
    it "checks whether tree visible from any side" do
      expect(subject.tree_visible?(1, 1)).to be(true)
      expect(subject.tree_visible?(2, 2)).to be(false)
      expect(subject.tree_visible?(3, 2)).to be(true)
      expect(subject.tree_visible?(3, 3)).to be(false)
    end
  end

  context "#viewable_from_left?" do
      it "check whether interior tree visible from left" do
        expect(subject.viewable_from_left?(1, 1)).to be(true)
        expect(subject.viewable_from_left?(2, 2)).to be(false)
        expect(subject.viewable_from_left?(3, 2)).to be(true)
        expect(subject.viewable_from_left?(3, 3)).to be(false)
    end

      it "checks whether outside tree visible from left" do
        expect(subject.viewable_from_left?(3, 0)).to be(true)
        expect(subject.viewable_from_left?(0, 2)).to be(false)
        expect(subject.viewable_from_left?(4, 0)).to be(true)
        expect(subject.viewable_from_left?(0, 3)).to be(true)
      end
  end

  context "#viewable_from_right?" do
    it "checks whether interior trees are visible from right" do
      expect(subject.viewable_from_right?(2, 3)).to be(true)
      expect(subject.viewable_from_right?(3, 3)).to be(false)
      expect(subject.viewable_from_right?(1, 2)).to be(true)
      expect(subject.viewable_from_right?(3, 1)).to be(false)
    end

    it "checks whether outside trees visible from right" do
      expect(subject.viewable_from_right?(3, 4)).to be(true)
      expect(subject.viewable_from_right?(3, 0)).to be(false)
      expect(subject.viewable_from_right?(4, 4)).to be(true)
      expect(subject.viewable_from_right?(0, 0)).to be(false)
    end
  end

  context "#viewable_from_top?" do
    it "checks whether interior trees are visible from top" do
      expect(subject.viewable_from_top?(1, 1)).to be(true)
      expect(subject.viewable_from_top?(2, 1)).to be(false)
      expect(subject.viewable_from_top?(1, 2)).to be(true)
      expect(subject.viewable_from_top?(3, 2)).to be(false)
    end

    it "checks whether outside trees are visible from top" do
      expect(subject.viewable_from_top?(0, 1)).to be(true)
      expect(subject.viewable_from_top?(1, 4)).to be(false)
      expect(subject.viewable_from_top?(2, 0)).to be(true)
      expect(subject.viewable_from_top?(4, 4)).to be(false)
    end
  end

  context "#viewable_from_bottom?" do
    it "checks whether interior trees are visible from bottom" do
      expect(subject.viewable_from_bottom?(3, 2)).to be(true)
      expect(subject.viewable_from_bottom?(2, 1)).to be(false)
      expect(subject.viewable_from_bottom?(3, 2)).to be(true)
      expect(subject.viewable_from_bottom?(3, 3)).to be(false)
    end

    it "checks whether outside trees are visible from bottom" do
      expect(subject.viewable_from_bottom?(4, 2)).to be(true)
      expect(subject.viewable_from_bottom?(0, 2)).to be(false)
      expect(subject.viewable_from_bottom?(4, 0)).to be(true)
      expect(subject.viewable_from_bottom?(2, 4)).to be(false)
    end
  end

  context "#solve_part1" do
    it "solves part one" do
      expect(subject.solve_part1).to eq(21)
    end
  end
end

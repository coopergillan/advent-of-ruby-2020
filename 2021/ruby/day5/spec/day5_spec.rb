require "day5"

describe OceanFloor do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "creates array of zeroes with length and width of highest number in coordinates" do
      expect(subject.floor_map).to match_array([
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      ])
    end
  end

  context "answering part 1" do
    let(:column_vent_line) { VentLine.new(2, 2, 2, 1) }
    let(:row_vent_line) { VentLine.new(0, 1, 2, 1) }

    let(:empty_3x3_array) { Array.new(3) { Array.new(3, 0) } }

    subject { described_class.new(empty_3x3_array, vent_lines) }

    context "#plot_coordinates" do
      let(:vent_lines) { [column_vent_line] }
      context "when given column-style coordinates" do
        it "increments the number at each point in a column" do
          subject.plot_coordinates
          expect(subject.floor_map).to match_array([
            [0, 0, 0],
            [0, 0, 1],
            [0, 0, 1],
          ])
        end
      end
      context "when given row-style coordinates" do
        let(:vent_lines) { [row_vent_line] }
        it "increments the number at each point in a row" do
          subject.plot_coordinates
          expect(subject.floor_map).to match_array([
            [0, 0, 0],
            [1, 1, 1],
            [0, 0, 0],
          ])
        end
      end
      context "when given both row and column coordinates that also overlap" do
        let(:vent_lines) { [column_vent_line, row_vent_line] }
        it "increments the number at each point in a row" do
          subject.plot_coordinates
          expect(subject.floor_map).to match_array([
            [0, 0, 0],
            [1, 1, 2],
            [0, 0, 1],
          ])
        end
      end
    end
  end

  context "#part1" do
    it "Gives the total count of plots greater than 1" do
      expect(subject.part1).to eq(5)
    end
  end

  context "answering part 2" do
    xit "Gives total count of plots including diagonals" do
      expect(subject.part2).to eq(12)
    end
  end
end

describe VentLine do
  subject { described_class.new(x1, y1, x2, y2) }
  context "#coordinates" do
    context "when the x coordinates match and make a vertical line" do
      let(:x1) { 1 }
      let(:y1) { 1 }
      let(:x2) { 1 }
      let(:y2) { 3 }
      it "gets each coordinate to be plotted with x the same and y incremental" do
        expect(subject.coordinates).to match_array([
          [1, 1], [1, 2], [1, 3],
        ])
      end
    end

    context "when the y coordinates match and make a horizontal line" do
      let(:x1) { 2 }
      let(:y1) { 5 }
      let(:x2) { 6 }
      let(:y2) { 5 }
      it "gets each coordinate to be plotted with x the same and y incremental" do
        expect(subject.coordinates).to match_array([
          [2, 5], [3, 5], [4, 5], [5, 5], [6, 5],
        ])
      end
    end

    context "when the x and y coordinates do not match for a diagonal line" do
      let(:x1) { 9 }
      let(:y1) { 7 }
      let(:x2) { 7 }
      let(:y2) { 9 }
      xit "gets each coordinate to be plotted with x the same and y incremental" do
        expect(subject.coordinates).to match_array([
          [9,7], [8, 8], [7, 9],
        ])
      end
    end
  end
end

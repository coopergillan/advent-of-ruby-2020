module Day5
  class BoardingPassList
    attr_accessor :passes

    def initialize(passes)
      @passes = passes
    end

    def self.from_file(filepath)
      new(File.foreach(filepath).map(&:chomp))
    end
  end

  class Part1
    ROWS = (0...128)
    COLUMNS = (0...8)

    class BoardingPass
      attr_accessor :row_data, :column_data

      def initialize(binary_input)
        matcher = binary_input.match(/(?<row_data>^[BF]{7})(?<column_data>[LR]{3})/)

        @row_data = matcher[:row_data].to_s
        @column_data = matcher[:column_data].to_s
      end

      def row
        row_finder = ROWS.to_a
        @row_data.each_char do |char|
          new_size = row_finder.size / 2
          if char == "F"
            row_finder = row_finder.first(new_size)
          elsif char == "B"
            row_finder = row_finder.last(new_size)
          end
        end
        row_finder.first
      end

      def column
        col_finder = COLUMNS.to_a
        @column_data.each_char do |char|
          new_size = col_finder.size / 2
          if char == "L"
            col_finder = col_finder.first(new_size)
          elsif char == "R"
            col_finder = col_finder.last(new_size)
          end
        end
        col_finder.first
      end
    end
  end
end


if $PROGRAM_NAME  == __FILE__
  puts "hello world"
  # day5 = Day5::Terrain.from_file("lib/day5_data.txt")
  #
  # puts "Answering part 1"
  # part1_count = Day5::Part1::Journey.new(3, 1).count_trees(day5)
  # puts "Got #{part1_count} trees"
  #
  # puts "Answering part 2"
  # slopes = [
  #     [1, 1],
  #     [3, 1],
  #     [5, 1],
  #     [7, 1],
  #     [1, 2],
  # ]
  # part2_answer = Day5::Part2::JourneyLog.new(slopes, day5).answer_part2
  # puts "Got #{part2_answer} for part 2 answer"
end

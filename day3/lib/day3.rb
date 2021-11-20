module Day3
  class Terrain
    attr_accessor :detail, :width

    def initialize(detail)
      @detail = detail
      @width = detail.first.size
    end

    def self.from_file(filepath)
      new(File.foreach(filepath).map(&:chomp))
    end
  end

  class Part1
    class Journey
      attr_accessor :run, :rise

      def initialize(run, rise)
        @run = run
        @rise = rise
      end

      def count_trees(terrain)
        horizontal_pos = 0
        (@rise...terrain.detail.size).step(@rise).each.reduce(0) do |tree_count, vertical_pos|
          if (horizontal_pos += @run) >= terrain.width
            horizontal_pos -= terrain.width
          end
          tree_count += terrain.detail[vertical_pos][horizontal_pos] == "#" ? 1 : 0
        end
      end
    end
  end

  class Part2
    class JourneyLog
      attr_accessor :slopes, :terrain

      def initialize(slopes, terrain)
        @slopes = slopes
        @terrain = terrain
      end

      def answer_part2
        log_tree_counts.reduce(1, :*)
      end

      def log_tree_counts
        @slopes.map do |(run, rise)|
          Part1::Journey.new(run, rise).count_trees(@terrain)
        end
      end
    end
  end
end


if $PROGRAM_NAME  == __FILE__
  day3 = Day3::Terrain.from_file("lib/day3_data.txt")

  puts "Answering part 1"
  part1_count = Day3::Part1::Journey.new(3, 1).count_trees(day3)
  puts "Got #{part1_count} trees"

  puts "Answering part 2"
  slopes = [
      [1, 1],
      [3, 1],
      [5, 1],
      [7, 1],
      [1, 2],
  ]
  part2_answer = Day3::Part2::JourneyLog.new(slopes, day3).answer_part2
  puts "Got #{part2_answer} for part 2 answer"
end

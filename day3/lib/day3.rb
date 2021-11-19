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

    def width
      @width |= detail.first.size
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
          horizontal_pos += @run
          if horizontal_pos >= terrain.width
            horizontal_pos -= terrain.width
          end

          tree_count += terrain.detail[vertical_pos][horizontal_pos] == "#" ? 1 : 0
        end
      end

      private

      def set_horizontal_position(curr_position, curr_line)
        curr_position >= curr_line.size ? curr_position - curr_line.size : curr_position
      end
    end
  end
end


if $PROGRAM_NAME  == __FILE__
  day3 = Day3::Terrain.from_file("lib/day3_data.txt")

  puts "Answering part 1"
  part1_count = Day3::Part1::Journey.new(3, 1).count_trees(day3)
  puts "Got #{part1_count} trees"
end

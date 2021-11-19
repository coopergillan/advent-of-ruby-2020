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

      def tree_count(terrain)
        horizontal_pos = 0
        tree_count = 0
        (@rise...terrain.detail.size).step(@rise).each do |vert_pos|
          horizontal_pos += @run
          if horizontal_pos >= terrain.width
            horizontal_pos -= terrain.width
          end

          if terrain.detail[vert_pos][horizontal_pos] == "#"
            tree_count += 1
          end
        end
        tree_count
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
  tree_count = Day3::Part1::Journey.new(3, 1).tree_count(day3)
  puts "Got #{tree_count} trees"
end

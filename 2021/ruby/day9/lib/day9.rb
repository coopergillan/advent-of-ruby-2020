class LavaTubeSurfer
  attr_accessor :heightmap, :height, :width

  def initialize(heightmap)
    @heightmap = heightmap
    @height = heightmap.transpose.first.size
    @width = heightmap.first.size
  end

  def self.from_file(filepath)
    heightmap = File.foreach(filepath, chomp: true).map do |line|
      line.each_char.map(&:to_i)
    end
    new(heightmap)
  end

  def neighbors(coordinates)
    row, column = coordinates

    # Check the row
    previous_row = row - 1
    next_row = row + 1

    # Check the columns
    previous_column = column - 1
    next_column = column + 1

    neighbors = [
      [row, previous_column],
      [previous_row, column],
      [row, next_column],
      [next_row, column],
    ]
    puts "Getting readhy to check neighboard: #{neighbors}"

    neighbors.map do |(row_check, column_check)|
      next unless row_check.between?(0, @height - 1) && column_check.between?(0, @width - 1)
        @heightmap[row_check][column_check]
    end.compact
  end

  def part1
    "wrong"
  end

  def part2
    "wrong again"
  end
end

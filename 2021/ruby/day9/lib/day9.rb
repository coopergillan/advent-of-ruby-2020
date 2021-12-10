class LavaTubeSurfer
  attr_accessor :heightmap

  def initialize(heightmap)
    @heightmap = heightmap
  end

  def self.from_file(filepath)
    heightmap = File.foreach(filepath, chomp: true).map do |line|
      line.each_char.map(&:to_i)
    end
    new(heightmap)
  end

  def neighbors(coordinates)
    row, column = coordinates
    # new_row = row + 1
    # new_column = column + 1

    point1 = @heightmap[row][column + 1]
    point2 = @heightmap[row + 1][column]
    return [point1, point2]
  end

  def part1
    "wrong"
  end

  def part2
    "wrong again"
  end
end

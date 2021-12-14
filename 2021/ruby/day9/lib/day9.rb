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
    raw_neighbor_coords(coordinates).map do |(row_check, column_check)|
      next unless row_check.between?(0, @height - 1) && column_check.between?(0, @width - 1)
        @heightmap[row_check][column_check]
    end.compact
  end

  def raw_neighbor_coords(coordinates)
    row, column = coordinates

    # TODO: find some Ruby helper methods like each_cons that can derive
    # these neighbors to each coordinate
    # Check the row
    # puts "Running neighbors for row: #{row} and column: #{column}"
    previous_row = row - 1
    next_row = row + 1

    # Check the columns
    previous_column = column - 1
    next_column = column + 1

    [
      [row, previous_column],
      [previous_row, column],
      [row, next_column],
      [next_row, column],
    ].map do |(row_check, column_check)|
      next unless row_check.between?(0, @height - 1) && column_check.between?(0, @width - 1)
      [row_check, column_check]
    end.compact
  end

  def higher_neighbors?(coordinates)
    row, column = coordinates
    neighbors(coordinates).map { |neighbor| neighbor > @heightmap[row][column] }.all?
  end

  def risk_level(coordinates)
    row, column = coordinates
    return @heightmap[row][column] + 1 if higher_neighbors?(coordinates)
    0
  end

  def part1
    risk_level_sum = 0
    @heightmap.each_with_index do |row, row_idx|
      row.each_with_index.map do |_, col_idx|
        # risk_level([row_idx, col_idx])
        this_level = risk_level([row_idx, col_idx])
        # puts "Calculated this_level: #{this_level}"
        risk_level_sum += this_level
      end
    end
    risk_level_sum
  end

  def in_basin?(coordinates)
    row, column = coordinates
    return false if @heightmap[row][column] == 9
    true
  end

  def basin_size(coordinates, visited = [])
    unvisited = [coordinates] - visited
    return if !in_basin?(coordinates) || unvisited.empty?

    visited << coordinates
    neighbors_check = raw_neighbor_coords(coordinates) - visited
    neighbors_check.each { |n| basin_size(n, visited) }
    visited.size
  end

  def part2
    basins = []
    @heightmap.each_with_index do |row, row_idx|
      row.each_with_index.map do |_, col_idx|
        coords = [row_idx, col_idx]
        if higher_neighbors?(coords)
          basins.push(basin_size(coords))
        end
      end
    end
    basins.sort[-3..].reduce(1, :*)
  end
end


if $PROGRAM_NAME  == __FILE__
  lava_tube = LavaTubeSurfer.from_file("lib/input.txt")

  puts "Answer for part 1: #{lava_tube.part1}"
  puts "Answer for part 2: #{lava_tube.part2}"
end

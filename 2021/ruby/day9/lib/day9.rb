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
  # def basin_size(coordinates, size = 0, visited = [])
    puts "Begin coordinates check for coordinates: #{coordinates}"
    unvisited = [coordinates] - visited
    puts "unvisited: #{unvisited}"
    return if (!in_basin?(coordinates) || unvisited.empty?)
    # size += 1
    # puts "Size is #{size} after increment"

    puts "visited before adding: #{visited}"
    # if
    visited << coordinates
    puts "visited after adding: #{visited}"
    neighbors_check = raw_neighbor_coords(coordinates) - visited
    neighbors_check.each do |n|
      puts "About to run for neighbor #{n} - visited: #{visited}"
      puts ""
      # basin_size(n, size, visited)
      basin_size(n, visited)
    end
    puts "visited: #{visited}"
    visited.size
    # size
  end

"""
0, 9 should be 1
0, 8 should be 1
0, 7 should be 1
0, 6 should be 1
0, 5 should be 1
0, 4 should be 0

1, 9 should be 1
1, 8 should be 1
1, 7 should be 0
1, 6 should be 1
1, 5 should be 0

2, 9 should be 1
2, 8 should be 0
"""


  # def basin_size(coordinates, size = 0, visited = [])
  #   puts "========================"
  #   puts "Beginning check for: #{coordinates}"
  #   unvisited = coordinates - visited
  #   if (unvisited.empty? || !in_basin?(coordinates))
  #     puts "unvisited: #{unvisited}"
  #     puts "in_basin?(coordinates): #{in_basin?(coordinates)}"
  #     puts "We are in the su;posed base case and size is: #{size}"
  #     return size
  #   end
  #   visited << coordinates
  #   size += 1
  #
  #   if (raw_neighbors = raw_neighbor_coords(coordinates))
  #     neighbors_to_check = raw_neighbors - visited
  #   else
  #     neighbors_to_check = []
  #   end
  #   neighbors_to_check.map do |neighbor_coords|
  #     puts "Checking neighbor_coords: #{neighbor_coords} with size: #{size}"
  #     basin_size(neighbor_coords, size, visited)
  #   end
  #   puts ""
  #   size
  # end

  # def basin_size(coordinates, size = 0, visited = [])
  #   unvisited = coordinates - visited
  #   puts "unvisited: #{unvisited}"
  #   return if unvisited.empty?
  #   visited << coordinates
  #   puts "Checking basin_size for coordinates: #{coordinates}"
  #   puts "size is: #{size}"
  #   puts "visited is: #{visited}"
  #   if !in_basin?(coordinates)
  #     puts "coordinates: #{coordinates} are not in a basin"
  #     puts "returning size: #{size}"
  #     return size
  #   end
  #   puts "coordinates: #{coordinates} are in a basin"
  #   puts "size stands at #{size} before increment"
  #
  #   # Increment by 1 if it is in a basin
  #   size += 1
  #   puts "size stands at #{size} after increment"
  #   puts ""
  #
  #   if (raw_neighbors = raw_neighbor_coords(coordinates))
  #     neighbors_to_check = raw_neighbors - visited
  #   else
  #     neighbors_to_check = []
  #   end
  #   puts "Checking for neighbors: #{neighbors_to_check}"
  #   # neighbors_to_check = raw_neighbor_coords(neighbors_to_check) - visited
  #   neighbors_to_check.map do |neighbor_coords|
  #     # puts "Now going to check neighbor_coords: #{neighbor_coords}"
  #     # puts "Size is at #{size}"
  #     # break if size >= 16
  #     return basin_size(neighbor_coords, size, visited)
  #   end
  #   puts ""
  #   size
  # end

  def part2
    "wrong again"
  end
end


if $PROGRAM_NAME  == __FILE__
  lava_tube = LavaTubeSurfer.from_file("lib/input.txt")

  puts "Answer for part 1: #{lava_tube.part1}"
end

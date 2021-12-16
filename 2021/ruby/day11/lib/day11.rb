class Cavern
  attr_accessor :octopus_map, :height, :width

  def initialize(octopus_map)
    @octopus_map = octopus_map
    @height = octopus_map.size
    @width = octopus_map.first.size
  end

  def self.from_file(filepath)
    octopus_map = File.foreach(filepath, chomp: true).map do |line|
      line.each_char.map do |octo|
        Octopus.new(octo.to_i)
      end
    end
    new(octopus_map)
  end

  def map_energies
    @octopus_map.map do |row|
      row.each do |octo|
      end
    end

    def step
      @octopus_map.each do |row|
        row.each do |octopus|
          octopus.increment_and_flash
        end
      end
    end

    # def neighbors(coordinates)
    #   raw_neighbor_coords(coordinates).map do |(row_check, column_check)|
    #     @heightmap[row_check][column_check]
    #   end.compact
    # end

    def raw_neighbor_coords(coordinates)
      row, column = coordinates

      # TODO: find some Ruby helper methods like each_cons that can derive neighbor coordinates
      previous_row = row - 1
      next_row = row + 1
      previous_column = column - 1
      next_column = column + 1

      neighbors_check = [
        [previous_row, previous_column],
        [previous_row, column],
        [previous_row, next_column],
        [row, previous_column],
        [row, next_column],
        [next_row, previous_column],
        [next_row, column],
        [next_row, next_column],
      ]

      neighbors_check.map do |(row_check, column_check)|
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
      # TODO: figure out how to derive this using reduce instead of adding to risk_level_sul
      risk_level_sum = 0
      @heightmap.each_with_index do |row, row_idx|
        row.each_with_index.map do |_, col_idx|
          this_level = risk_level([row_idx, col_idx])
          risk_level_sum += this_level
        end
      end
      risk_level_sum
    end

    def basin_size(coordinates, visited = [])
      unvisited = [coordinates] - visited
      return if !in_basin?(coordinates) || unvisited.empty?

      visited << coordinates
      (raw_neighbor_coords(coordinates) - visited).each { |n| basin_size(n, visited) }
      visited.size
    end

    def part2
      # TODO: figure out how to derive `basins` with map
      basins = []
      @heightmap.each_with_index do |row, row_idx|
        row.each_with_index.map do |_, col_idx|
          coords = [row_idx, col_idx]
          if higher_neighbors?(coords)
            basins.push(basin_size(coords))
          end
        end
      end
      basins.sort.last(3).reduce(1, :*)
    end

    private

    def in_basin?(coordinates)
      row, column = coordinates
      return false if @heightmap[row][column] == 9
      true
    end
  end
end


class Octopus
  attr_accessor :energy_level

  def initialize(energy_level)
    @energy_level = energy_level
  end

  def increment_and_flash
    flash = 0
    if @energy_level == 9
      @energy_level = 0
      flash += 1
    else
      @energy_level += 1
    end
    flash
  end
end


if $PROGRAM_NAME  == __FILE__
  lava_tube = LavaTubeSurfer.from_file("lib/input.txt")

  puts "Answer for part 1: #{lava_tube.part1}"
  puts "Answer for part 2: #{lava_tube.part2}"
end

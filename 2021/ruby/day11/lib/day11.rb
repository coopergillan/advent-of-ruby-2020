class Cavern
  attr_accessor :octopus_map, :height, :width, :flashes

  def initialize(octopus_map)
    @octopus_map = octopus_map
    @height = octopus_map.size
    @width = octopus_map.first.size
    @flashes = 0
  end

  def self.from_file(filepath)
    octopus_map = File.foreach(filepath, chomp: true).map do |line|
      line.each_char.map do |octo|
        octo.to_i
      end
    end
    new(octopus_map)
  end

  def flash_check(row, column, flashed)
    if @octopus_map[row][column] > 9
      @flashes += 1
      flashed.push([row, column])
      @octopus_map[row][column] = 0

      # Check each neighbor and increment those that have not yet flashed
      raw_neighbor_coords(row, column).each do |(n_row, n_col)|
        if !flashed.include?([n_row, n_col])
          @octopus_map[n_row][n_col] += 1
          flash_check(n_row, n_col, flashed)
        end
      end
    end
  end

  def step
    # Increment each octopus before all else (I re-read the instructions!)
    @octopus_map.each_with_index.map do |row, row_idx|
      row.each_with_index.map do |_, octo_idx|
        @octopus_map[row_idx][octo_idx] += 1
      end
    end

    # Go back through to log the flashes and increment neighbors
    flashed = []
    @octopus_map.each_with_index.map do |row, row_idx|
      row.each_with_index.map do |_, octo_idx|
        flash_check(row_idx, octo_idx, flashed)
      end
    end
    flashed
  end

  def raw_neighbor_coords(row, column)
    neighbors_check = Range.new(row - 1, row + 1).to_a
      .product(Range.new(column - 1, column + 1).to_a)
      .reject { |(r, c)| (r == row && c == column ) }

    neighbors_check.map do |(row_check, column_check)|
      next unless row_check.between?(0, @height - 1) && column_check.between?(0, @width - 1)
      [row_check, column_check]
    end.compact
  end

  def part1
    100.times { step }
    @flashes
  end

  def part2
    flashed = []
    step_number = 0
    cavern_size = @height * @width

    while flashed.size < cavern_size
      flashed = step
      step_number += 1
    end
    step_number
  end
end


if $PROGRAM_NAME  == __FILE__
  cavern1 = Cavern.from_file("lib/input.txt")
  puts "Answer for part 1: #{cavern1.part1}"

  cavern2 = Cavern.from_file("lib/input.txt")
  puts "Answer for part 2: #{cavern2.part2}"
end

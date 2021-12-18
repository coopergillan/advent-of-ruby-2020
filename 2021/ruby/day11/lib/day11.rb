class Cavern
  BANNER = "==============================="
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
      puts "About to flash for row: #{row} - column: #{column} - @flashes: #{@flashes}"
      @flashes += 1
      puts "Flashed - @flashes: #{@flashes}"
      flashed.push([row, column])
      @octopus_map[row][column] = 0
      puts "Got a flash for row: #{row} - column: #{column}"
      puts "Total @flashes: #{@flashes}"
      raw_neighbor_coords(row, column).each do |(n_row, n_col)|
        puts "Running for neighbors: row: #{n_row} col: #{n_col} - @octopus_map[n_row][n_col]: #{@octopus_map[n_row][n_col]}"

        # Increment the next one and check for flashes if it hasn't already flashed
        if !flashed.include?([n_row, n_col])
          @octopus_map[n_row][n_col] += 1
        flash_check(n_row, n_col, flashed)
        end
      end
    end
  end

  def step
    puts BANNER
    puts "Beginning withstep"
    puts BANNER
    # step_flashes = 0

    # Need to incremenet everyone first (look at the instructions!)
    @octopus_map.each_with_index.map do |row, row_idx|
      row.each_with_index.map do |octopus, octo_idx|
        # require "pry"; binding.pry
        puts "Firs tloop through - checking row_idx: #{row_idx} - octo_idx: #{octo_idx}"
        puts "Before increment: @octopus_map[row][octo_idx]: #{@octopus_map[row_idx][octo_idx]}"
        @octopus_map[row_idx][octo_idx] += 1
        puts "After increment: @octopus_map[row][octo_idx]: #{@octopus_map[row_idx][octo_idx]}"
      end
    end

    # Now check for flashes
    flashed = []
    @octopus_map.each_with_index.map do |row, row_idx|
      row.each_with_index.map do |octopus, octo_idx|
        puts "Second loop through - checking row_idx: #{row_idx} - octo_idx: #{octo_idx}"
        puts "Before flash check: @flashes: #{@flashes} - flashed: #{flashed}"
        flash_check(row_idx, octo_idx, flashed)
      end
    end
    puts BANNER
    puts "Finished wthstep! @ocotopus_Map: #{@octopus_map}"
    puts BANNER
    return flashed
  end

  def raw_neighbor_coords(row, column)
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

  def part1
    100.times { step }
    @flashes
  end

  def part2
    cavern_size = @height * @width

    flashed = []
    step_number = 0

    while flashed.size < cavern_size
      puts "Step number: #{step_number}"
      flashed = step
      step_number += 1
      if flashed.size == cavern_size
        puts "Step number #{step_number} - cavern_size: #{cavern_size} - flashed.size: #{flashed.size}"
        return step_number
      end
    end
  end
end


# class Octopus
#   attr_accessor :energy_level
#
#   def initialize(energy_level)
#     @energy_level = energy_level
#   end
#
# end


if $PROGRAM_NAME  == __FILE__
  cavern = Cavern.from_file("lib/input.txt")

  # puts "Answer for part 1: #{cavern.part1}"
  puts "Answer for part 2: #{cavern.part2}"
end

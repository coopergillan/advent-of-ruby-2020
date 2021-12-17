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
        Octopus.new(octo.to_i)
      end
    end
    new(octopus_map)
  end

  def map_energies
    @octopus_map.map do |row|
      row.map do |octo|
        octo.energy_level
      end
    end
  end

  def increment_and_flash(row, column, flashes = 0)
    octopus = @octopus_map[row][column]
    if octopus.energy_level < 9
      octopus.energy_level += 1
      return 0
    elsif octopus.energy_level == 9
      octopus.energy_level = 0
      @flashes += 1
      puts "Got a flash for row: #{row} - column: #{column} - total flashes: #{flashes}"
      raw_neighbor_coords(row, column).each do |(n_row, n_col)|
        puts "Running for neighbors: row: #{n_row} col: #{n_col}"
        increment_and_flash(n_row, n_col, flashes)
      end
    end
    # puts "Going to return flahses: #{flashes} now"
    # return flashes
  end

  def step
    puts "Beginning new step!"
    # step_flashes = 0
    @octopus_map.each_with_index.map do |row, row_idx|
      row.each_with_index.map do |octopus, octo_idx|
        increment_and_flash(row_idx, octo_idx)
        # flash_check = increment_and_flash(row_idx, octo_idx, step_flashes)
        # if flash_check.zero?
        #   puts "No flashes for this octopus row: #{row_idx} column: #{octo_idx} - energy: #{octopus.energy_level}"
        #   next
        # end
        # puts "Got flash_check: #{flash_check}"
        # @flashes += flash_check
        puts "Have @flahses: #{@flashes}"
        puts "========================"
        # next if flashed.nil?
        # # If it did flash, increase the count and run for each neighbor
        # @flashes += flashed
        # raw_neighbor_coords([row_idx, octo_idx]).each do |(n_row, n_col)|
        #     # require "pry"; binding.pry
        #     @octopus_map[n_row][n_col].increment_and_flash
      end
    end
    puts "Finsihed next step!"
    puts "=============================="
    puts "=============================="
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

  end

  def part2

  end
end


class Octopus
  attr_accessor :energy_level

  def initialize(energy_level)
    @energy_level = energy_level
  end

end


if $PROGRAM_NAME  == __FILE__
  lava_tube = LavaTubeSurfer.from_file("lib/input.txt")

  puts "Answer for part 1: #{lava_tube.part1}"
  puts "Answer for part 2: #{lava_tube.part2}"
end

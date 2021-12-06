class OceanFloor
  attr_accessor :floor_map, :vent_lines

  def initialize(floor_map, vent_lines)
    @floor_map = floor_map
    @vent_lines = vent_lines
  end

  def self.from_file(filepath)
    highest = 0
    vent_lines = []
    File.foreach(filepath).map do |line|
      (x1, y1), (x2, y2) = line.split(" -> ").map do |pair|
        pair.split(",").map { |coord| coord.to_i }
      end
      if (high_check = [x1, y1, x2, y2].max) > highest
        highest = high_check
        high_check = 0
      end
      vent_lines.push(VentLine.new(x1, y1, x2, y2))
    end
    floor_map_size = highest + 1
    floor_map = Array.new(floor_map_size) { Array.new(floor_map_size, 0) }

    new(floor_map, vent_lines)
  end

  def plot_coordinates(check_diagonals: false)
    @vent_lines.each do |vent_line|
      vent_line.coordinates(check_diagonals: check_diagonals).each do |(column, row)|
        @floor_map[row][column] += 1
      end
    end
  end

  def part1
    plot_coordinates

    total = 0
    @floor_map.each do |row|
      row.each do |column|
        if column > 1
          total += 1
        end
      end
    end
    total
  end

  def part2
    plot_coordinates(check_diagonals: true)

    total = 0
    @floor_map.each do |row|
      row.each do |column|
        if column > 1
          total += 1
        end
      end
    end
    total
  end
end

class VentLine
  attr_accessor :x1, :y1, :x2, :y2

  def initialize(x1, y1, x2, y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def coordinates(check_diagonals: false)
    coords = []
    if x_coords_match?
      y_min, y_max = [@y1, @y2].sort
      coords = (y_min..y_max).map { |y_coord| [@x1, y_coord] }
    elsif y_coords_match?
      x_min, x_max = [@x1, @x2].sort
      coords = (x_min..x_max).map { |x_coord| [x_coord, @y1] }
    elsif check_diagonals
      if diagonal?
        x_min, x_max = [@x1, @x2].sort
        y_min, y_max = [@y1, @y2].sort
        if sw_ne_diagonal?
          y_coords = (y_min..y_max).reverse_each
        elsif nw_se_diagonal?
          y_coords = (y_min..y_max)
        end
        coords = (x_min..x_max).zip(y_coords)
      end
    end
    coords
  end

  private

  def x_coords_match?
    @x1 == @x2
  end

  def y_coords_match?
    @y1 == @y2
  end

  def diagonal?
    sw_ne_diagonal? || nw_se_diagonal?
  end

  def sw_ne_diagonal?
    (@x1 + @y1) == (@x2 + @y2)
  end

  def nw_se_diagonal?
    (@x1 - @y1).abs == (@x2 - @y2).abs
  end
end


if $PROGRAM_NAME  == __FILE__
  ocean_floor1 = OceanFloor.from_file("lib/input.txt")
  part1_answer = ocean_floor1.part1
  puts "Answer for part 1: #{part1_answer}"

  ocean_floor2 = OceanFloor.from_file("lib/input.txt")
  part2_answer = ocean_floor2.part2
  puts "Answer for part 2: #{part2_answer}"
end

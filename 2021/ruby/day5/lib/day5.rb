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

    # puts "Preparing to instantiate with #{vent_lines.size} vent lines"
    # puts "vent_lines: #{vent_lines}"
    # puts "vent_lines[3].coordinates: #{vent_lines[3].coordinates}"
    # puts "floor_map is #{floor_map.size} rows"
    new(floor_map, vent_lines)
  end

  def plot_coordinates
    @vent_lines.each do |vent_line|
      vent_line.coordinates.each do |(column, row)|
        @floor_map[row][column] += 1
      end
    end
  end

  def plot_coordinates_with_diagonals
    @vent_lines.each do |vent_line|
      vent_line.coordinates_with_diagonals.each do |(column, row)|
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
    plot_coordinates_with_diagonals
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

  def coordinates
    coords = []
    if @x1 == @x2
      y_min, y_max = [@y1, @y2].sort
      coords = (y_min..y_max).map { |y_coord| [@x1, y_coord] }
    elsif @y1 == @y2
      x_min, x_max = [@x1, @x2].sort
      coords = (x_min..x_max).map { |x_coord| [x_coord, @y1] }
    end
    coords
  end

  def coordinates_with_diagonals
    coords = []
    if x_coords_match?
      y_min, y_max = [@y1, @y2].sort
      coords = (y_min..y_max).map { |y_coord| [@x1, y_coord] }
    elsif y_coords_match?
      x_min, x_max = [@x1, @x2].sort
      coords = (x_min..x_max).map { |x_coord| [x_coord, @y1] }
    elsif (@x1 + @y1) == (@x2 + @y2)
      puts " FOund SW/NE diag??????"
      x_min, x_max = [@x1, @x2].sort
      y_min, y_max = [@y1, @y2].sort
      puts "Got x_min, x_max: #{x_min} #{x_max}"
      puts "Got y_min, y_max: #{y_min} #{y_max}"
      coords = (x_min..x_max).zip((y_min..y_max).reverse_each)
    elsif (@x1 - @y1).abs == (@x2 - @y2).abs
      puts " FOund NW/SE diag??????"
      x_min, x_max = [@x1, @x2].sort
      y_min, y_max = [@y1, @y2].sort
      puts "Got x_min, x_max: #{x_min} #{x_max}"
      puts "Got y_min, y_max: #{y_min} #{y_max}"
      coords = (x_min..x_max).zip((y_min..y_max))
    #   if @x1 > @x2
    #     x_vals = (@x1..@x2).reverse_each
    #     if @y1  > @y2
    #       y_vals = (@y1..@y2).reverse_each
    #     else
    #       y_vals = (@y1..@y2)
    #     end
    #     coords = x_vals.zip(y_vals)
    #   end
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
end


if $PROGRAM_NAME  == __FILE__
  ocean_floor1 = OceanFloor.from_file("lib/input.txt")
  part1_answer = ocean_floor1.part1
  puts "Answer for part 1: #{part1_answer}"

  ocean_floor2 = OceanFloor.from_file("lib/input.txt")
  part2_answer = ocean_floor2.part2
  puts "Answer for part 2: #{part2_answer}"
end

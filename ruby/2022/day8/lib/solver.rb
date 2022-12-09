class TopLevelClass

  attr_accessor :input_data, :height, :width

  def initialize(input_data)
    @input_data = input_data
    @height = input_data.size
    @width = input_data.first.size
  end

  def self.from_file(filepath)
    ###
    # For reading each line into an array
    raw_content = File.foreach(filepath, chomp: true).map do |line|
      line.chars.map(&:to_i)
    end

    # Instantiate the top-level class with processed data
    new(raw_content)
  end

  def solve_part1
    col = row = 0
    total_trees = 0
    (0...height).each do |row|
      (0...width).each do |col|
        # Count top and bottom rows, plus first and last columns
        if tree_visible?(row, col)
          total_trees += 1
        end
      end
    end
    total_trees
  end

  def tree_visible?(row, col)
    return true if viewable_from_left?(row, col)
    return true if viewable_from_right?(row, col)
    return true if viewable_from_top?(row, col)
    return true if viewable_from_bottom?(row, col)
    false
  end

  def viewable_from_left?(row, col)
    return true if col == 0
    # Each value to left is lower than this value
    cols_to_check = (0..(col - 1))
    puts "cols_to_check: #{cols_to_check}"
    val_to_check = input_data[row][col]
    puts "Checking #{val_to_check}"
    checked = input_data[row][cols_to_check].map do |tree|
      puts "checking tree: #{tree}"
      tree.to_i < val_to_check
    end
    puts "checked: #{checked}"
    checked.all?
  end

  def viewable_from_right?(row, col)
    puts "col: #{col}"
    puts "width - 1: #{width - 1}"
    # return true if col == width - 1
    # Each value to right is lower than this value
    cols_to_check = ((col + 1)..width)
    puts "cols_to_check: #{cols_to_check}"
    val_to_check = input_data[row][col]
    puts "Checking #{val_to_check}"
    checked = input_data[row][cols_to_check].map do |tree|
      puts "checking tree: #{tree}"
      tree.to_i < val_to_check
    end
    puts "checked: #{checked}"
    checked.all?
  end

  def viewable_from_top?(row, col)
    # Each value to right is lower than this value
    rows_to_check = (0..(row - 1))
    puts "rows_to_check: #{rows_to_check}"
    val_to_check = input_data[row][col]
    puts "Checking #{val_to_check}"
    checked = rows_to_check.map do |check_row|
      tree = input_data[check_row][col]
      puts "checking tree: #{tree}"
      tree.to_i < val_to_check
    end
    puts "checked: #{checked}"
    checked.all?
  end

  def viewable_from_bottom?(row, col)
    # Each value to right is lower than this value
    start_row = row +1
    # puts "start_row: #{start_row}"
    rows_to_check = ((row + 1)...width)
    # puts "rows_to_check: #{rows_to_check}"
    val_to_check = input_data[row][col]
    # puts "Checking #{val_to_check}"
    checked = rows_to_check.map do |check_row|
      # puts "check_row: #{check_row}"
      # require "pry"; binding.pry
      tree = input_data[check_row][col]
      # puts "checking tree: #{tree}"
      tree.to_i < val_to_check
    end
    # puts "checked: #{checked}"
    checked.all?
  end

  # def solve_part2
  #   8
  # end
end

class ParticularClass

  attr_accessor :input1, :input2

  def initialize(input1, input2)
    @input1 = input1
    @input2 = input2
  end

  def self.from_raw(raw_input)
    raw_input1, raw_input2 = raw_input
    new(raw_input1, raw_input2)
  end
end

if $PROGRAM_NAME  == __FILE__
  top_level_instance = TopLevelClass.from_file("lib/input.txt")

  part1 = top_level_instance.solve_part1
  puts "Part one answer: #{part1}"

  # part2 = top_level_instance.solve_part2
  # puts "Part two answer: #{part2}"
end

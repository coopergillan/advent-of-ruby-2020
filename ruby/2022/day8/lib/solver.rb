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
    (0...height).map do |row|
      (0...width).map do |col|
        # Count top and bottom rows, plus first and last columns
        tree_visible?(row, col) ? 1 : 0
      end.reduce(:+)
    end.reduce(:+)
  end

  def tree_visible?(row, col)
    viewable_from_left?(row, col) ||
      viewable_from_right?(row, col) ||
      viewable_from_top?(row, col) ||
      viewable_from_bottom?(row, col)
  end

  def viewable_from_left?(row, col)
    return true if col == 0

    cols_to_check = (0..(col - 1))
    input_data[row][cols_to_check].map do |tree|
      tree.to_i < input_data[row][col]
    end.all?
  end

  def viewable_from_right?(row, col)
    cols_to_check = ((col + 1)..width)
    checked = input_data[row][cols_to_check].map do |tree|
      tree.to_i < input_data[row][col]
    end.all?
  end

  def viewable_from_top?(row, col)
    rows_to_check = (0..(row - 1))
    checked = rows_to_check.map do |check_row|
      input_data[check_row][col].to_i < input_data[row][col]
    end.all?
  end

  def viewable_from_bottom?(row, col)
    rows_to_check = ((row + 1)...width)
    checked = rows_to_check.map do |check_row|
      input_data[check_row][col].to_i < input_data[row][col]
    end.all?
  end
end

if $PROGRAM_NAME  == __FILE__
  top_level_instance = TopLevelClass.from_file("lib/input.txt")

  part1 = top_level_instance.solve_part1
  puts "Part one answer: #{part1}"
end

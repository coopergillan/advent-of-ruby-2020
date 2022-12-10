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

  def solve_part2
    result = (0...height).map do |row|
      (0...width).map do |col|
        # Count top and bottom rows, plus first and last columns
        scenic_score(row, col)
      end.max
    end
    puts "result: #{result}"
    result.max
  end

  def scenic_score(row, col)
    left = trees_to_left(row, col)
    puts "left: #{left}"

    right = trees_to_right(row, col)
    puts "right: #{right}"

    above = trees_above(row, col)
    puts "above: #{above}"

    below = trees_below(row, col)
    puts "below: #{below}"

    total = [left, right, above, below]
    puts "total: #{total}"
    scenic_score = total.reduce(:*)
    puts "scenic_score: #{scenic_score}"
    scenic_score
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

  def trees_to_left(row, col)
    cols_to_check = (0..(col - 1)).to_a.reverse
    current_tree = input_data[row][col]
    puts "current_tree: #{current_tree}"
    tree_count = 0
    cols_to_check.each do |check_col|
      tree = input_data[row][check_col].to_i
      puts "tree: #{tree}"
      if tree.to_i < current_tree
        tree_count += 1
      elsif tree.to_i >= current_tree
        tree_count += 1
        break
      end
    end
    tree_count
  end

  def viewable_from_right?(row, col)
    cols_to_check = ((col + 1)..width)
    checked = input_data[row][cols_to_check].map do |tree|
      tree.to_i < input_data[row][col]
    end.all?
  end

  def trees_to_right(row, col)
    cols_to_check = ((col + 1)..width)
    current_tree = input_data[row][col]
    puts "current_tree: #{current_tree}"
    tree_count = 0
    checked = input_data[row][cols_to_check].each do |tree|
      puts "tree: #{tree}"
      if tree.to_i < current_tree
        tree_count += 1
      elsif tree.to_i >= current_tree
        tree_count += 1
        break
      end
    end
    tree_count
  end

  def viewable_from_top?(row, col)
    rows_to_check = (0..(row - 1))
    checked = rows_to_check.map do |check_row|
      input_data[check_row][col].to_i < input_data[row][col]
    end.all?
  end

  def trees_above(row, col)
    rows_to_check = (0..(row - 1)).to_a.reverse
    current_tree = input_data[row][col]
    tree_count = 0
    checked = rows_to_check.each do |check_row|
      tree = input_data[check_row][col].to_i
      if tree < current_tree
        tree_count += 1
      elsif tree >= current_tree
        tree_count += 1
        break
      end
    end
    tree_count
  end

  def viewable_from_bottom?(row, col)
    rows_to_check = ((row + 1)...width)
    checked = rows_to_check.map do |check_row|
      input_data[check_row][col].to_i < input_data[row][col]
    end.all?
  end

  def trees_below(row, col)
    rows_to_check = ((row + 1)...width)
    current_tree = input_data[row][col]
    tree_count = 0
    checked = rows_to_check.map do |check_row|
      tree = input_data[check_row][col].to_i
      if tree < current_tree
        tree_count += 1
      elsif tree >= current_tree
        tree_count += 1
        break
      end
    end
    tree_count
  end
end

if $PROGRAM_NAME  == __FILE__
  top_level_instance = TopLevelClass.from_file("lib/input.txt")

  part1 = top_level_instance.solve_part1
  puts "Part one answer: #{part1}"

  part2 = top_level_instance.solve_part2
  puts "Part two answer: #{part2}"
end

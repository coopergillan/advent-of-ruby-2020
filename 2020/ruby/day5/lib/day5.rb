module Day5
  class BoardingPassList
    attr_accessor :passes

    def initialize(passes)
      @passes = passes
    end

    def self.from_file(filepath)
      new(File.foreach(filepath).map(&:chomp))
    end

    def answer_part1
      max_id = 0
      @passes.each do |pass_input|
        boarding_pass = BoardingPass.new(pass_input)
        if boarding_pass.seat_id > max_id
          max_id = boarding_pass.seat_id
        end
      end
      max_id
    end
  end

  class BoardingPass
    attr_accessor :row_data, :column_data
    ROWS = (0...128)
    COLUMNS = (0...8)

    def initialize(binary_input)
      matcher = binary_input.match(/(?<row_data>^[BF]{7})(?<column_data>[LR]{3})/)

      @row_data = matcher[:row_data].to_s
      @column_data = matcher[:column_data].to_s
    end

    def row
      row_finder = ROWS.to_a
      @row_data.each_char do |char|
        new_size = row_finder.size / 2
        if char == "F"
          row_finder = row_finder.first(new_size)
        elsif char == "B"
          row_finder = row_finder.last(new_size)
        end
      end
      row_finder.first
    end

    def column
      col_finder = COLUMNS.to_a
      @column_data.each_char do |char|
        new_size = col_finder.size / 2
        if char == "L"
          col_finder = col_finder.first(new_size)
        elsif char == "R"
          col_finder = col_finder.last(new_size)
        end
      end
      col_finder.first
    end

    def seat_id
      (row * 8) + column
    end
  end
end


if $PROGRAM_NAME  == __FILE__
  puts "hello world"
  boarding_pass_list = Day5::BoardingPassList.from_file("lib/day5_data.txt")

  puts "Answering part 1"
  part1_answer = boarding_pass_list.answer_part1
  puts "Max seat_id for the group is: #{part1_answer}"
end

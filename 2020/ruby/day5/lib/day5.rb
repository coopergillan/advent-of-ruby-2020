module Day5
  ROWS = (0...128)
  COLUMNS = (0...8)

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

    def default_seats_map
      min_id = BoardingPass.calculate_seat_id(ROWS.min, COLUMNS.min)
      max_id = BoardingPass.calculate_seat_id(ROWS.max, COLUMNS.max)
      (min_id..max_id).to_a
    end

    def remove_existing_passes(seats_map)
      @passes.each do |pass_input|
        boarding_pass = BoardingPass.new(pass_input)
        seats_map.delete(boarding_pass.seat_id)
      end
      seats_map
    end

    def answer_part2(seats_map = default_seats_map)
      seats_map = remove_existing_passes(seats_map)

      seats_map.each do |seat_id|
        next if seat_id_has_adjacent?(seats_map, seat_id)
        return seat_id
      end
    end

    def seat_id_has_adjacent?(seats_map, seat_id)
      seats_map.include?(seat_id + 1) || seats_map.include?(seat_id - 1)
    end
  end

  class BoardingPass
    attr_accessor :row_data, :column_data

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

    def self.calculate_seat_id(row_number, column_number)
      (row_number * 8) + column_number
    end

    def seat_id
      self.class.calculate_seat_id(row, column)
    end
  end
end


if $PROGRAM_NAME  == __FILE__
  boarding_pass_list = Day5::BoardingPassList.from_file("lib/day5_data.txt")

  part1_answer = boarding_pass_list.answer_part1
  puts "Part 1 Answer: max seat_id for the group is: #{part1_answer}"

  part2_answer = boarding_pass_list.answer_part2
  puts "Part 2 answer: remaining seat_id is: #{part2_answer}"
end

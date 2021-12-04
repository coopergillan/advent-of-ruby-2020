class BingoGame
  attr_accessor :drawn_numbers, :boards

  def initialize(drawn_numbers, boards)
    @drawn_numbers = raw_input.split(/\n\n/).first
    @boards = boards
  end

  def self.from_file(filepath)
    File.readlines(filepath, chomp: true).each_with_index do |line, idx|
      if idx.zero?
        drawn_numbers = line
        puts "drawn_numbers:  #{drawn_numbers}"
        next
      end
      puts "line: #{line}"
    end
  end
end

class BingoBoard
  attr_accessor :board

  def initialize(board)
    @board = board
    @called_numbers = []
  end

  def self.from_raw(raw_board)
    new(
      raw_board.split(/\n/).map do |line|
        line.split.map { |raw_number| {value: raw_number.to_i, called: false} }
      end
    )
  end

  def call_number(number)
    @board.each do |row|
      row.each do |spot|
        if number == spot[:value]
          spot[:called] = true
        end
      end
    end
  end

  def uncalled_numbers
    uncalled = []
    @board.each do |row|
      row.each do |spot|
        if spot[:called] == false
          uncalled.push(spot[:value])
        end
      end
    end
    uncalled
  end

  def has_win?
    has_row_win? || has_column_win?
  end

  private

  def has_row_win?
    @board.map { |row| row.map { |spot| spot[:called] }.all? }.any?
  end

  def has_column_win?
    @board.transpose.map { |row| row.map { |spot| spot[:called] }.all? }.any?
  end

end


if $PROGRAM_NAME  == __FILE__
  puts "Hello world - it's time for part 4"

  day4 = Day4.from_file("lib/input.txt")
  puts "Got input for day4: #{day4.input}"
end

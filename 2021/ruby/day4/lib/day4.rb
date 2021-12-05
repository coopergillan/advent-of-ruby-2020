class BingoGame
  attr_accessor :drawn_numbers, :boards

  def initialize(drawn_numbers, boards)
    @drawn_numbers = drawn_numbers
    @boards = boards
  end

  def self.from_file(filepath)
    raw_content = File.read(filepath, chomp: true).split("\n\n")
    drawn_numbers = raw_content.first.split(",").map(&:to_i)

    boards = raw_content[1..].map do |raw_board|
      BingoBoard.from_raw(raw_board)
    end

    new(drawn_numbers, boards)
  end

  def part1
    @drawn_numbers.each do |number|
      @boards.each do |board|
        board.call_number(number)
        if board.has_win?
          return board.uncalled_numbers.reduce(:+) * number
        end
      end
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
  bingo_game = BingoGame.from_file("lib/input.txt")

  part1_answer = bingo_game.part1
  puts "Answer for part 1: #{part1_answer}"
end

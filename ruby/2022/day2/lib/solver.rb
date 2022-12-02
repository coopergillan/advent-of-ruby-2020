class RockPaperScissorsGame

  attr_accessor :input_data

  def initialize(input_data)
    @input_data = input_data
  end

  def self.from_file(filepath)
    new(File.foreach(filepath, chomp: true).map { |line| line.split(/ /) })
  end

  def solve_part1
    input_data.map { |raw_round| Part1Round.from_raw(raw_round).self_score }.reduce(:+)
  end

  def solve_part2
    input_data.map { |raw_round| Part2Round.from_raw(raw_round).self_score }.reduce(:+)
  end
end

module Round
  SHAPE_POINTS = {
    rock: 1,
    paper: 2,
    scissors: 3,
  }
  OUTCOME_POINTS = {
    win: 6,
    draw: 3,
  }
  OPPONENT_SHAPE_KEY = {
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors,
  }
  def self_score
    SHAPE_POINTS.fetch(self_shape) + OUTCOME_POINTS.fetch(outcome, 0)
  end
end

class Part1Round
  include Round

  SELF_SHAPE_KEY = {
    "X" => :rock,
    "Y" => :paper,
    "Z" => :scissors,
  }
  attr_accessor :opponent_shape, :self_shape

  def initialize(opponent_shape, self_shape)
    @opponent_shape = opponent_shape
    @self_shape = self_shape
  end

  def self.from_raw(input_array)
    opponent_shape, self_shape = input_array
    new(OPPONENT_SHAPE_KEY[opponent_shape], SELF_SHAPE_KEY[self_shape])
  end

  def outcome
    case opponent_shape
    when :rock
      case self_shape when :paper then :win when :rock then :draw end
    when :paper
      case self_shape when :paper then :draw when :scissors then :win end
    when :scissors
      case self_shape when :scissors then :draw when :rock then :win end
    end
  end
end

class Part2Round
  include Round

  OUTCOME_KEY = {
    "X" => :lose,
    "Y" => :draw,
    "Z" => :win,
  }
  attr_accessor :opponent_shape, :outcome

  def initialize(opponent_shape, outcome)
    @opponent_shape = opponent_shape
    @outcome = outcome
  end

  def self.from_raw(input_array)
    opponent_shape, outcome = input_array
    new(OPPONENT_SHAPE_KEY[opponent_shape], OUTCOME_KEY[outcome])
  end

  def self_shape
    case opponent_shape
    when :rock
      case outcome when :lose then :scissors when :draw then :rock when :win then :paper end
    when :paper
      case outcome when :lose then :rock when :draw then :paper when :win then :scissors end
    when :scissors
      case outcome when :lose then :paper when :draw then :scissors when :win then :rock end
    end
  end
end

if $PROGRAM_NAME  == __FILE__
  round_info = RockPaperScissorsGame.from_file("lib/input.txt")

  part1 = round_info.solve_part1
  puts "Part one answer: #{part1}"

  part2 = round_info.solve_part2
  puts "Part two answer: #{part2}"
end

class RockPaperScissorsGame

  attr_accessor :input_data

  def initialize(input_data)
    @input_data = input_data
  end

  def self.from_file(filepath)
    new(File.foreach(filepath, chomp: true).map { |line| line.split(/ /) })
  end

  def solve_part1
    input_data.reduce(0) do |total_self_score, round|
      total_self_score + Round.from_raw(round).self_score
    end
  end
end

class Round
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

  def self_score
    outcome = case opponent_shape
    when :rock
      case self_shape when :paper then :win when :rock then :draw end
    when :paper
      case self_shape when :paper then :draw when :scissors then :win end
    when :scissors
      case self_shape when :scissors then :draw when :rock then :win end
    end
    SHAPE_POINTS.fetch(self_shape) + OUTCOME_POINTS.fetch(outcome, 0)
  end
end

if $PROGRAM_NAME  == __FILE__
  round_info = RockPaperScissorsGame.from_file("lib/input.txt")

  part1 = round_info.solve_part1
  puts "Part one answer: #{part1}"
end

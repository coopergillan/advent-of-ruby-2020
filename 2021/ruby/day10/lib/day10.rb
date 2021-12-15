class SyntaxChecker
  attr_accessor :syntax_lines

  def initialize(syntax_lines)
    @syntax_lines = syntax_lines
  end

  def self.from_file(filepath)
    syntax_lines = File.foreach(filepath, chomp: true).map { |line| SyntaxLine.new(line) }
    new(syntax_lines)
  end

  def part1
    @syntax_lines.map { |line| line.score }.reduce(:+)
  end

  def part2
    raw_completed_lines = @syntax_lines.map { |line| line.part2_score }
    completed_lines = raw_completed_lines.delete_if { |line| line.zero? }.sort
    mid_point_idx = (completed_lines.size / 2)
    completed_lines[mid_point_idx]
  end
end


class SyntaxLine
  attr_accessor :chars

  OPEN_CHARS = ["(", "[", "{", "<"]
  CLOSE_CHARS = [")", "]", "}", ">"]
  CLOSE_TO_OPEN = CLOSE_CHARS.zip(OPEN_CHARS).to_h
  PART1_POINTS = {
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137,
  }
  PART2_POINTS = {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4,
  }

  def initialize(chars)
    @chars = chars
  end

  def parse
    tracking = []
    @chars.each_char.each do |char|
      if closing_char?(char)
        if (last_char = tracking.pop) != CLOSE_TO_OPEN[char]
          return char
        end
      end
      tracking.push(char) if opening_char?(char)
    end
    tracking
  end

  def score
    PART1_POINTS.fetch(parse, 0)
  end

  def complete_line
    parsed_line = parse
    return if parsed_line.is_a?(String)
    parse.reverse.map{ |char| CLOSE_TO_OPEN.invert[char] }.join
  end

  def part2_score
    score = 0
    complete_line&.each_char do |char|
      score *= 5
      score += PART2_POINTS[char]
    end
    score
  end

  private

  def closing_char?(char)
    CLOSE_CHARS.include?(char)
  end

  def opening_char?(char)
    OPEN_CHARS.include?(char)
  end
end


if $PROGRAM_NAME  == __FILE__
  checker = SyntaxChecker.from_file("lib/input.txt")

  puts "Answer for part 1: #{checker.part1}"
  puts "Answer for part 2: #{checker.part2}"
end

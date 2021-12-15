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
    @signal_combos.map { |combo| combo.output_to_number }.reduce(:+)
  end
end


class SyntaxLine
  attr_accessor :chars

  OPEN_CHARS = ["(", "[", "{", "<"]
  CLOSE_CHARS = [")", "]", "}", ">"]
  CLOSE_TO_OPEN = CLOSE_CHARS.zip(OPEN_CHARS).to_h
  POINTS = {
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137,
  }

  def initialize(chars)
    @chars = chars
  end

  def parse
    tracking = []
    @chars.each_char.each do |char|
      puts "Checking char: #{char}"
      if CLOSE_CHARS.include?(char)
        puts "char #{char} in CLOSE_CHARS"
        last_char = tracking.pop
        puts "last_char: #{last_char}"
        if last_char != CLOSE_TO_OPEN[char]
          puts "last_char: #{last_char}"
          return char
        end
      end
      tracking.push(char) if OPEN_CHARS.include?(char)
    end
  end

  def score
    POINTS.fetch(parse, 0)
  end
end


if $PROGRAM_NAME  == __FILE__
  checker = SyntaxChecker.from_file("lib/input.txt")

  puts "Answer for part 1: #{checker.part1}"
  # puts "Answer for part 2: #{solver.part2}"
end

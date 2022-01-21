class WrappingPaper
  attr_accessor :dot_details, :fold_instructions

  def initialize(dot_details, fold_instructions)
    @dot_details = dot_details
    @fold_instructions = fold_instructions
  end

  def self.from_file(filepath)
    raw_content = File.read(filepath, chomp: true).split("\n\n")

    fold_instructions = raw_content.pop.split(/\n/)
    dot_details = raw_content.first.split(/\n/).map { |raw_coords| raw_coords.split(",").map(&:to_i) }
    new(dot_details, fold_instructions)
  end

  def height
    @dot_details.map { |(_, row)| row }.max + 1
  end

  def width
    @dot_details.map { |(column, _)| column }.max + 1
  end

  def dot_count
    @dot_details.size
  end

  def vertical_fold(fold_row)
    6
  end

  def part1
  end

  def part2
  end
end


if $PROGRAM_NAME  == __FILE__
  paper1 = WrappingPaper.from_file("lib/input.txt")
  puts "Answer for part 1: #{paper1.part1}"

  paper2 = WrappingPaper.from_file("lib/input.txt")
  puts "Answer for part 2: #{paper2.part2}"
end

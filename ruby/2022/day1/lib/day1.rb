class CalorieCounter
	attr_accessor :elf_info

  def initialize(elf_info)
    @elf_info = elf_info
  end

  def self.from_file(filepath)
    new(File.foreach(filepath, chomp: true).map(&:to_i))
  end

  private

  def elevations_to_check
    @sonar_report[1..-1]
  end

  def increase?(previous, current)
    unless previous.nil?
      return current > previous
    end
    false
  end
end

if $PROGRAM_NAME  == __FILE__
  sonar_report = SonarSweeper.from_file("lib/input.txt")

  part1_increases = sonar_report.count_increases(SonarSweeper::PART1_WINDOW_SIZE)
  puts "Found #{part1_increases} increases in elevation for part 1"

  part2_increases = sonar_report.count_increases(SonarSweeper::PART2_WINDOW_SIZE)
  puts "Found #{part2_increases} increases in elevation for part 2"
end

class SonarSweeper
  attr_accessor :sonar_report

  PART1_WINDOW_SIZE = 1
  PART2_WINDOW_SIZE = 3

  def initialize(sonar_report)
    @sonar_report = sonar_report
  end

  def self.from_file(filepath)
    new(File.foreach(filepath, chomp: true).map(&:to_i))
  end

  def count_increases(window_size)
    (0...elevations_to_check.size).each.reduce(0) do |increases, idx|
      window = idx...idx + window_size

      previous_window = @sonar_report[window].reduce(:+)
      current_window = elevations_to_check[window].reduce(:+)

      increases += increase?(previous_window, current_window) ? 1 : 0
    end
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

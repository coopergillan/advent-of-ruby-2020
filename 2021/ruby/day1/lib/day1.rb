class SonarSweeper
  attr_accessor :sonar_report

  PART2_WINDOW_SIZE = 3

  def initialize(sonar_report)
    @sonar_report = sonar_report
  end

  def self.from_file(filepath)
    new(File.foreach(filepath, chomp: true).map(&:to_i))
  end

  def answer_part1
    elevations_to_check.each_with_index.reduce(0) do |increases, (elevation, index)|
      previous_elevation = @sonar_report[index]
      increases += (increase?(previous_elevation, elevation) ? 1 : 0)
    end
  end

  def answer_part2
    (0...elevations_to_check.size).each.reduce(0) do |increases, idx|
      checked_window = idx...idx + PART2_WINDOW_SIZE

      previous_window = @sonar_report[checked_window].reduce(:+)
      current_window = elevations_to_check[checked_window].reduce(:+)

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

  part1_increases = sonar_report.answer_part1
  puts "Found #{part1_increases} increases in elevation for part 1"

  part2_increases = sonar_report.answer_part2
  puts "Found #{part2_increases} increases in elevation for part 2"
end

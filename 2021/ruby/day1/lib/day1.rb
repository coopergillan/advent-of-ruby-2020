class SonarSweeper
  attr_accessor :sonar_report

  def initialize(sonar_report)
    @sonar_report = sonar_report
  end

  def self.from_file(filepath)
    new(File.foreach(filepath, chomp: true).map(&:to_i))
  end

  def count_increases
    elevations_to_check.each_with_index.reduce(0) do |increases, (elevation, index)|
      previous_elevation = @sonar_report[index]
      increases += (increase?(previous_elevation, elevation) ? 1 : 0)
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
  increases = sonar_report.count_increases
  puts "Found #{increases} increases in elevation"
end

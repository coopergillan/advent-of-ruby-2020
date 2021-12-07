class QuestionLog
  attr_accessor :question_groups

  def initialize(question_groups)
    @question_groups = question_groups
  end

  def self.from_file(filepath)
    new(
      File.read(filepath, chomp: true).split(/\n\n/).map do |line|
        line.chomp.split(/\n/).flatten
      end
     )
  end

  def part1
    @question_groups.map { |group| group.uniq.join.each_char.uniq.size }.reduce(:+)
  end

  def part2
    @question_groups.map do |group|
      group.uniq.join.each_char.uniq.map do |q|
        group.map { |person| person.include?(q) }.all? ? 1 : 0
      end.reduce(:+)
    end.reduce(:+)
  end
end


if $PROGRAM_NAME  == __FILE__
  question_log = QuestionLog.from_file("lib/input.txt")

  part1_answer = question_log.part1
  puts "Got part1_answer: #{part1_answer}"

  part2_answer = question_log.part2
  puts "Got part2_answer: #{part2_answer}"
end

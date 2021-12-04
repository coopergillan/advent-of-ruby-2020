class QuestionLog
  attr_accessor :question_groups

  def initialize(question_groups)
    @question_groups = question_groups
  end

  def self.from_file(filepath)
    new(
      File.read(filepath, chomp: true).split(/\n\n/).map do |line|
        # line.chomp.gsub(/\n/, " ")
        puts "line: #{line}"
        line.chomp.split(/\n/).flatten
      end
     )
  end
end


if $PROGRAM_NAME  == __FILE__
  puts "hello world"
  # question_log = QuestionLog.from_file("lib/input.txt")
end

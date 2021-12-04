class QuestionLog
  attr_accessor :questions

  def initialize(questions)
    @questions = questions
  end

  def self.from_file(filepath)
    new(
      File.read(filepath, chomp: true).split(/\n\n/).map do |line|
        line.chomp.gsub(/\n/, " ")
      end
    )
  end
end


if $PROGRAM_NAME  == __FILE__
  puts "hello world"
  # question_log = QuestionLog.from_file("lib/input.txt")
end

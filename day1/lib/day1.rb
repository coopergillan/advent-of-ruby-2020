class Day1
  attr_accessor :expense_report, :desired_sum

  def initialize(expense_report, desired_sum)
    @expense_report = expense_report
    @desired_sum = desired_sum
  end

  def self.from_file(filepath, desired_sum)
    expense_report_data = []
    File.foreach(filepath).each do |line|
      expense_report_data.append(line.chomp.to_i)
    end
    new(expense_report_data, desired_sum)
  end

  def find_sum_elements
    @expense_report.each_with_index do |line, index|
      desired_element = @desired_sum - line.to_i
      all_others = @expense_report[(index + 1)..] + @expense_report[0...index]
      if all_others.include?(desired_element)
        return [line, desired_element]
      end
    end
    return
  end

  def calculate_answer
    element1, element2 = find_sum_elements
    puts "Found #{element1} and #{element2} that sum to #{@desired_sum}"
    element1 * element2
  end
end

def answer_part1
  part1 = Day1.from_file("lib/day1_part1.txt", 2020)
  answer = part1.calculate_answer
  puts "Got answer: #{answer}"
end

if $PROGRAM_NAME  == __FILE__
	puts "Answering part 1"
	answer_part1
end

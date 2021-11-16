class Day1
  attr_accessor :expense_report

  def initialize(expense_report)
    @expense_report = expense_report
  end

  def self.from_file(filepath)
    expense_report_data = []
    File.foreach(filepath).each do |line|
      expense_report_data.append(line.chomp.to_i)
    end
    new(expense_report_data)
  end

  def answer_part1(desired_sum)
    element1, element2 = find_sum_elements(desired_sum)
    if [element1, element2].all?
      puts "Found #{element1} and #{element2} that sum to #{element1 + element2}"
      product = element1 * element2
      puts "Product is #{product}"
      product
    end
  end

  private

  def find_sum_elements(desired_sum)
    @expense_report.each_with_index do |line, index|
      desired_element = desired_sum - line.to_i
      all_others = @expense_report[(index + 1)..] + @expense_report[0...index]
      if all_others.include?(desired_element)
        return line, desired_element
      end
    end
    return
  end
end

def answer_part1
  part1 = Day1.from_file("lib/day1_data.txt")
  answer = part1.answer_part1(2020)
  puts "Got answer: #{answer}"
end

if $PROGRAM_NAME  == __FILE__
  day1 = Day1.from_file("lib/day1_data.txt")

  puts "Answering part 1"
  day1.answer_part1(2020)
end

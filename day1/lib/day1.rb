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
    element1, element2 = find_sum_elements(desired_sum, @expense_report)
    if [element1, element2].all?
      puts "Found #{element1} and #{element2} that sum to #{element1 + element2}"
      product = element1 * element2
      puts "Product is #{product}"
      product
    end
  end

  def answer_part2(desired_sum)
    @expense_report.each_with_index do |elem, idx|
      next_desired_sum = desired_sum - elem
      all_others = @expense_report[(idx + 1)..] + @expense_report[0...idx]
      second, third = find_sum_elements(next_desired_sum, all_others)
      if [second, third].all?
        puts "Found #{elem}, #{second}, #{third} - sum is #{desired_sum}"
        product = elem * second * third
        puts "Product is #{product}"
        return product
      end
    end
  end

  private

  def find_sum_elements(desired_sum, array_to_search)
    array_to_search.each_with_index do |line, idx|
      desired_element = desired_sum - line.to_i
      all_others = array_to_search[(idx + 1)..] + array_to_search[0...idx]
      if all_others.include?(desired_element)
        return line, desired_element
      end
    end
    return
  end
end

if $PROGRAM_NAME  == __FILE__
  day1 = Day1.from_file("lib/day1_data.txt")

  puts "Answering part 1"
  day1.answer_part1(2020)

  puts "Answering part 2"
  day1.answer_part2(2020)
end

class BagInfo
  attr_accessor :type, :capacity

  def self.from_raw(raw_input)
    type, raw_capacity = raw_input.split(" bags contain ")
    raw_capacity = raw_capacity.chomp(".")
    puts "type: #{type} - raw_capacity: #{raw_capacity}"

    new(type, raw_capacity)
  end

  def initialize(type, capacity)
    @type = type
    @capacity = capacity
  end

  def parse_capacity(raw_input)
    capacity_hash = {}
    return capacity_hash if raw_input == "no other bags"

    puts "getting ready to tap raw_input #{raw_input}"
    # {}.tap do |hash|
    raw_input.split(",").each do |raw_bag|
      puts "Checking raw_bag: #{raw_bag}"
      bag_regex = /^(?<bag_count>\d{1}) (?<bag_type>\w+\s{1}\w+) bag(s)?$/
      bag_matcher = raw_bag.match(bag_regex)
      puts "bag_matcher: #{bag_matcher}"
      if bag_matcher
        puts "did we make it to building the hash?"
        capacity_hash[bag_matcher[:bag_type].to_s] = bag_matcher[:bag_count].to_i
      end
    end
    capacity_hash
  end

    # matcher = raw_input.match(/^(?<bag_type>\w+\s{1}\w+)\sbags contain\s(?<raw_capacity>.*)\.$/)
    # if matcher
    #   bag_type = matcher[:bag_type].to_s
    #   puts "Check bag_type: #{bag_type}"
    #   raw_capacity = matcher[:raw_capacity].to_s
    #   puts "raw_capacity: #{raw_capacity}"
    # end
    # if raw_capacity == "no other bags"
    #   capacity = nil
    # else
    #   capacity_matcher = raw_capacity.match(/^(?<part1>.*)\sbag(s)?((,\s{1})?(?<part2>.*)\sbag(s)?)?$/)
    #   puts "capacity_matcher: #{capacity_matcher}"
    #
    #   raw_part1 = capacity_matcher[:part1].to_s
    #   raw_part2 = capacity_matcher[:part2].to_s
    #
    #   puts "raw_part1: #{raw_part1}"
    #   puts "raw_part2: #{raw_part2}"
    #   capacity = {}
    #
    #   bag1_regex = /(?<count1>\d{1})\s(?<type1>\w+\s{1}\w+)/
    #   bag1_matcher = raw_part1.match(bag1_regex)
    #   puts "bag1_matcher: #{bag1_matcher}"
    #
    #   if bag1_matcher
    #     if bag1_matcher[:count1] && bag1_matcher[:type1]
    #       capacity.merge!({bag1_matcher[:type1] => bag1_matcher[:count1].to_i})
    #     end
    #   end
    #
    #   bag2_regex = /(?<count2>\d{1})\s(?<type2>\w+\s{1}\w+)/
    #   bag2_matcher = raw_part2.match(bag2_regex)
    #   puts "bag2_matcher: #{bag2_matcher}"
    #
    #   if bag2_matcher
    #     if bag2_matcher[:count2] && bag2_matcher[:type2]
    #       capacity.merge!({bag2_matcher[:type2] => bag2_matcher[:count2].to_i})
    #     end
    #   end

      # capacity_regex = /(?<count1>\d{1})\s(?<type1>\w+\s{1}\w+)\sbag(s)?((,\s{1})?(?<count2>\d{1})(?<type2>\w+\s{1}\w+)\sbag(s)?)?/
      # capacity_matcher = raw_capacity.match(capacity_regex)
      # puts "capacity_matcher: #{capacity_matcher}"

      # if capacity_matcher
      #   if capacity_matcher[:count1] && capacity_matcher[:type1]
      #     capacity.merge!({capacity_matcher[:type1] => capacity_matcher[:count1].to_i})
      #   end
      #   if capacity_matcher[:count2] && capacity_matcher[:type2]
      #     capacity.merge!({capacity_matcher[:type2] => capacity_matcher[:count2].to_i})
      #   end
      # end
  #   end
  #
  #   puts "using capacity: #{capacity}"
  #   puts "finished bag_tupe: #{bag_type}"
  #   puts "#################"
  #   BagDescription.new({bag_type => capacity})
  # end
end


#   def part1
#     @question_groups.map { |group| group.uniq.join.each_char.uniq.size }.reduce(:+)
#   end
#
#   def part2
#     @question_groups.map do |group|
#       group.uniq.join.each_char.uniq.map do |q|
#         group.map { |person| person.include?(q) }.all? ? 1 : 0
#       end.reduce(:+)
#     end.reduce(:+)
#   end
# end


if $PROGRAM_NAME  == __FILE__
  puts "Hello, world"
  # question_log = QuestionLog.from_file("lib/input.txt")
  #
  # part1_answer = question_log.part1
  # puts "Got part1_answer: #{part1_answer}"
  #
  # part2_answer = question_log.part2
  # puts "Got part2_answer: #{part2_answer}"
end
#
# class BagChecker
#   def self.from_file(filepath)
#     new(
#       File.read(filepath, chomp: true).split(/\n\n/).map do |line|
#         line.chomp.split(/\n/).flatten
#       end
#      )
#   end
# end

# config = {
#   "light red": {"bright white": 1, "muted yellow": 2},
#   "dark orange": {"bright white": 3, "muted yellow": 4},
#   "bright white": {"shiny gold": 1},
#   "muted yellow": {"shiny gold": 2, "faded blue": 9},
# }


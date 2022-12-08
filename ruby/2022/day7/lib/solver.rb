class TopLevelClass

  attr_accessor :input_data, :file_totals

  def initialize(input_data)
    @input_data = input_data
    @directory_contents = {}
    @file_totals = {}
  end

  def self.from_file(filepath)
    ###
    # For reading each line into an array
    raw_content = File.foreach(filepath, chomp: true).to_a

    # For processing that content, for example to an integer
    # processed_content = raw_content.map { |line| line.map(:&to_i) }

    ###
    # For reading input with line breaks that distinguish separate objects
    # raw_content = File.read(filepath, chomp: true).split(/\n\n/)

    # For processing each line within the separate objects, for example, getting the integer of each line
    # processed_content = raw_content.map { |line| line.split(/\n/).map(&:to_i) }

    # Delete this placeholder processed content before using

    # Instantiate the top-level class with processed data
    new(raw_content)
  end

  def solve_part1
    current_dir = ""
    command = ""
    last_command = ""
    input_data.each do |line|
      if line.start_with?("$ ")
        command = line.split("$ ").last
        if command.start_with?("cd")
          current_dir = command.split(/ /).last
          last_command = "cd"
        end
        # Move on if ls
        if command.start_with?("ls")
          last_command = "ls"
          next
        end
      elsif !line.start_with?("$ ") && last_command == "ls"
        if !@directory_contents.has_key?(current_dir)
          @directory_contents[current_dir] = []
        end
        @directory_contents[current_dir].push(line)
      end
    end

    # Now go through and total stuff that isn't a directory?
    @directory_contents.each do |directory, contents|
      contents.each do |item|
        next if item.start_with?("dir ")
        if !@file_totals.has_key?(directory)
          @file_totals[directory] = 0
        end
        @file_totals[directory] += item.split(/ /).first.to_i

      end
    end

    puts "@file_totals: #{@file_totals}"
    puts "@directory_contents: #{@directory_contents}"
    # Okay now total them????
    # puts "Getting ready for final total"
    # threshold = 100_000
    # result = 0
    # @directory_contents.each do |directory, _|
    #   this_result = get_directory_size(directory)
    #   if this_result < threshold
    #     # puts "About to add to result #{result}"
    #     result += this_result
    #     # puts "Added to result which is now #{result}"
    #   end
    # end
    # #   contents.each do |item|
    # #     if item.start_with?("dir ")
    # #       this_dir_total += file_totals[item.split("dir ").last]
    # #     else
    # #       this_dir_total += item.split(" ").first.to_i
    # #     end
    # #   end
    # #   result += this_dir_total
    # # end
    # result
  end

  def get_directory_size(directory)
    total = 0
    @directory_contents[directory].each do |item|
      if !item.start_with?("dir ")
        # puts "item: #{item}"
        total += item.split(" ").first.to_i
      elsif item.start_with?("dir ")
        checked_dir = item.split(" ").last
        # puts "Checking dir: #{checked_dir}"
        this_dir_size = get_directory_size(checked_dir)
        # puts "directory #{checked_dir} has this_dir_size: #{this_dir_size}\n\n"
        total += this_dir_size
      end
    end
    total
  end

  def solve_part2
    8
  end
end

# class Directory
#
#   attr_accessor :contents
#
#   def initialize(contents)
#     @contents = contents
#   end
#
#   def self.from_raw(raw_input)
#     raw_input1, raw_input2 = raw_input
#     new(raw_input1, raw_input2)
#   end
# end

if $PROGRAM_NAME  == __FILE__
  top_level_instance = TopLevelClass.from_file("lib/input.txt")

  part1 = top_level_instance.solve_part1
  puts "Part one answer: #{part1}"

  # part2 = top_level_instance.solve_part2
  # puts "Part two answer: #{part2}"
end

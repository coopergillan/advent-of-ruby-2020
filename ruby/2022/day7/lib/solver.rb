class TopLevelClass

  attr_accessor :input_data # , :file_totals

  def initialize(input_data)
    @input_data = input_data
  end

  def self.from_file(filepath)
    raw_contents = File.foreach(filepath, chomp: true).map do |line|
      line.split(/ /).filter_map do |item|
        if item.to_i > 0
          item.to_i
        elsif !item.start_with?("$")
          item
        end
      end
    end

    new(raw_contents)
  end

  def solve_part1
    result = 0
    directory_sizes.each do |directory, total_size|
      # puts "checking directory: #{directory} with total_size: #{total_size}"
      if total_size < 100_000
        # puts "directory: #{directory} has total_size #{total_size}"
        result += total_size
        # puts "Now have result: #{result}"
      end
    end
    result
  end

  def absolute_paths
    current_path = []
    result = []

    last_command = nil
    input_data.each do |item|
      # puts "Checking item #{item}"
      if item.first == "cd"
        # puts "Looking at a cd - item: #{item}"
        if item.last == ".."
          current_path.pop
          # puts "Moved down a directory - current_path: #{current_path.join}"
        elsif item.last != ".."
          if item.last == "/"
            current_path.push(item.last)
          else
            current_path.push("#{item.last}/")
          end
          # puts "Moved into a directory - current_path: #{current_path.join}"
        end
        last_command = "cd"
        # puts "set last_command to cd - last_command: #{last_command}"
      elsif item.first == "ls"
        last_command = "ls"
      elsif last_command == "ls"
        # puts "last command ls"
        # if item.first == "dir"
        #   result.push(
        # end
        if item.first.to_i > 0
          # puts "found item for filename? #{item}"
          file_name = current_path.join + item.last
          # puts "about to append file_name #{file_name} and item.first #{item.first} to result"
          # puts "working with current_path: #{current_path.join}"
          result.push([file_name, item.first])
        end
        # puts "What is item: #{item} if we don't have an integer"
        # next
      end
    end
    result
  end

  def directory_sizes
    sizes = Hash.new(0)
    absolute_paths.each do |path|
      # puts "path: #{path}"
      file_path, file_size = path

      # Check for paths by splitting on directory
      details = file_path.split("/")
      while details.size > 1
        next_check = details.shift
        if next_check == ""
            sizes["/"] += file_size
        else
          sizes[next_check] += file_size
        end
      end
    end
    sizes
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

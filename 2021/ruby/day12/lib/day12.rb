class CaveMap
  BANNER = "================================================="
  attr_accessor :connections

  def initialize(connections)
    @connections = connections
  end

  def self.from_file(filepath)
    connections = Hash.new([])
    File.foreach(filepath, chomp: true).map do |line|
      start_cave, end_cave = line.split("-")
      puts "Processing raw line: #{line} - start_cave: #{start_cave} end_cave: #{end_cave}"
      if connections.has_key?(start_cave)
        connections[start_cave].append(end_cave)
      else
        connections[start_cave] = [end_cave]
      end

      if end_cave != "end" && start_cave != "start"
        puts "Starting the reverse insert: end_cave: #{end_cave} start_cave: #{start_cave}"
        if connections.has_key?(end_cave)
          connections[end_cave].append(start_cave)
        else
          connections[end_cave] = [start_cave]
        end
      end
    end
    new(connections)
  end

  def build_paths(start_cave = "start", current_path = [], visited = [], all_paths = [], counter=0)
    current_path.push(start_cave) if current_path.empty?

    puts "Starting build_paths for start_cave: #{start_cave}"

    @connections[start_cave].each do |connecting_cave|
      next if visited.include?(start_cave)
      puts "Checking connecting_cave: #{connecting_cave} for start_cave: #{start_cave}"
      # Yep, since I still don't know how to get this to stop
      counter += 1
      # break if counter > 9

      if visited.include?(connecting_cave)
        puts "It says we have already visited connecting_cave: #{connecting_cave} - visited: #{visited}"
        next
      end
      # Don't bother if it's a small cave with only small cave connections
      next if (small_cave?(start_cave) && small_cave?(connecting_cave))

      if connecting_cave == "end"
        next_path = current_path + [connecting_cave]
        next if all_paths.include?(next_path)
        all_paths.push(next_path)
        puts "Finished adding next_path: #{next_path} to all_paths: #{all_paths}"
      elsif !small_cave?(connecting_cave) || (small_cave?(connecting_cave) && !current_path.include?(connecting_cave)) # !visited.include?(connecting_cave)
          next_path = current_path + [connecting_cave]
        # next_path = current_path + [connecting_cave]
          puts "next_path is now: #{next_path}"

        # Mark a small cave as visited
          visited.push(start_cave) if small_cave?(start_cave)
          puts "Visited is now #{visited}"

          puts "About to do recursive with connecting_cave: #{connecting_cave} - current_path: #{current_path}"
        build_paths(connecting_cave, next_path, visited, all_paths, counter)  # current_path [start, A] find branch from b, end
      end
      puts BANNER
      visited = []
    end
    all_paths
  end

  def part1

  end

  def part2

  end

  private

  def small_cave?(cave)
    (cave != cave.upcase) && !["start", "end"].include?(cave)
  end
end


if $PROGRAM_NAME  == __FILE__
  cave_map = CaveMap.from_file("lib/input.txt")

  puts "Answer for part 1: #{cave_map.part1}"
  puts "Answer for part 2: #{cave_map.part2}"
end

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

  def build_paths(start_cave = "start", current_path = [], visited = [], all_paths = [])
    current_path.push(start_cave) if current_path.empty?

    @connections[start_cave].each do |conn|
      if conn == "end"
        all_paths.push(current_path + [conn])
        puts "Finished one: all_paths: #{all_paths}"
        next
      elsif !visited.include?(conn) || !small_cave?(conn)
        next_path = current_path + [conn]

        # Mark a small cave as visited
        visited.push(start_cave) if small_cave?(start_cave)

        puts "About to do recursive with conn: #{conn} - current_path: #{current_path}"
        build_paths(conn, next_path, visited, all_paths)  # current_path [start, A] find branch from b, end
      end
      puts BANNER
    end
    all_paths
  end

  def part1

  end

  def part2

  end

  private

  def small_cave?(cave)
    cave != cave.upcase
  end
end


if $PROGRAM_NAME  == __FILE__
  cave_map = CaveMap.from_file("lib/input.txt")

  puts "Answer for part 1: #{cave_map.part1}"
  puts "Answer for part 2: #{cave_map.part2}"
end

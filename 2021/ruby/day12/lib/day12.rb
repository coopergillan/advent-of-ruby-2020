class CaveMap
  BANNER = "================================================="
  attr_accessor :connections

  def initialize(connections)
    @connections = connections
  end

  def self.build_connections(filepath)
    connections = Hash.new([])
    File.foreach(filepath, chomp: true).map do |line|
      cave1, cave2 = line.split("-")
      puts "Processing raw line: #{line} - cave1: #{cave1} cave2: #{cave2}"

      if cave1 != "end" && cave2 != "start"
        if connections.has_key?(cave1)
          connections[cave1].append(cave2)
        else
          connections[cave1] = [cave2]
        end
        puts "FIRST SECTION: Added cave1: #{cave1} and cave2: #{cave2} to connections: #{connections}"
      end

      if cave2 != "end" && cave1 != "start"
        puts "Starting the reverse insert: cave2: #{cave2} cave1: #{cave1}"
        if connections.has_key?(cave2)
          connections[cave2].append(cave1)
        else
          connections[cave2] = [cave1]
        end
        puts "SECOND SECTION: Added cave1: #{cave1} and cave2: #{cave2} to connections: #{connections}"
      end
    end
    connections
  end

  def self.from_file(filepath)
    connections = build_connections(filepath)
    new(connections)
  end

  def build_paths(start_cave = "start", current_path = [], visited = [], all_paths = [])
    current_path.push(start_cave) if current_path.empty?

    # puts "Starting build_paths for start_cave: #{start_cave}"

    @connections[start_cave].each do |connecting_cave|
      next if visited.include?(start_cave)
      # puts "Checking connecting_cave: #{connecting_cave} for start_cave: #{start_cave}"
      # Yep, since I still don't know how to get this to stop
      # counter += 1
      # break if counter > 19

      if visited.include?(connecting_cave)
        # puts "It says we have already visited connecting_cave: #{connecting_cave} - visited: #{visited}"
        next
      end
      # Don't bother if it's a small cave with only small cave connections
      if (small_cave?(start_cave) && @connections[connecting_cave]&.all? { |cave| @connections[cave]&.all? { |another| small_cave?(another) } } )
        # puts "start_cave: #{start_cave} is a small cave and all connecting_caves: #{@connections[connecting_cave]} are also - skipping"
        next
      end

      if connecting_cave == "end"
        next_path = current_path + [connecting_cave]
        if !all_paths.include?(next_path)
          all_paths.push(next_path)
          # puts "Finished adding next_path: #{next_path} to all_paths: #{all_paths}"
        end
      elsif !small_cave?(connecting_cave) || (small_cave?(connecting_cave) && !current_path.include?(connecting_cave))
        next_path = current_path + [connecting_cave]
        # puts "next_path is now: #{next_path}"

        # Mark a small cave as visited
        if small_cave?(start_cave)
          # puts "First time we visited small_cave: #{start_cave} - going to add to visited: #{visited}"
          visited.push(start_cave)
          # puts "Added small_cave: #{start_cave} to visited: #{visited}"
        end
        # puts "Visited is now #{visited}"

        # puts "About to do recursive with connecting_cave: #{connecting_cave} - next_path/current_path: #{next_path}"
        build_paths(connecting_cave, next_path, visited, all_paths)
      end
      # puts BANNER
      visited = []
    end
    all_paths
  end

  def build_paths_part2(start_cave = "start", current_path = [], visited = {}, all_paths = [])
    current_path.push(start_cave) if current_path.empty?

    puts "Starting build_paths_part2 for start_cave: #{start_cave}"

    @connections[start_cave].each do |connecting_cave|
      if visited.has_key?(start_cave)
        puts "Okay, checking for visited to start_cave: #{start_cave} - visited: #{visited}"
        next if visited.values.any? { |c| c == 2 }
      end
      puts "Checking connecting_cave: #{connecting_cave} for start_cave: #{start_cave}"
      # Yep, since I still don't know how to get this to stop
      # counter += 1
      # break if counter > 19

      if visited.has_key?(connecting_cave)
        if visited.values.any? { |c| c == 2 }
          puts "It says that one cave has already been visited twice: #{visited}"
          # puts "It says we have already visited connecting_cave: #{connecting_cave} - visited: #{visited}"
          next
        end
      end
      # Don't bother if it's a small cave with only small cave connections
      # if (small_cave?(start_cave) && @connections[connecting_cave]&.all? { |cave| @connections[cave]&.all? { |another| small_cave?(another) } } )
      #   # puts "start_cave: #{start_cave} is a small cave and all connecting_caves: #{@connections[connecting_cave]} are also - skipping"
      #   next
      # end

      if connecting_cave == "end"
        next_path = current_path + [connecting_cave]

        # Check that the path has not yet been added
        if !all_paths.include?(next_path)

          # Now check that the path only has one repeated small cave
          small_caves_keys = @connections.keys { |conn_key| small_cave?(conn_key) }
          if (next_path.count { |val| small_caves_keys.include?(val) } / small_caves_keys.size) < 2
            all_paths.push(next_path)
            puts "Finished adding next_path: #{next_path} to all_paths: #{all_paths}"
          end
        end
      elsif !small_cave?(connecting_cave) || (small_cave?(connecting_cave) && (!visited.values.any? { |c| c == 2 }) && current_path.count(connecting_cave) < 2)
        next_path = current_path + [connecting_cave]
        puts "next_path is now: #{next_path}"

        # Mark a small cave as visited
        if small_cave?(start_cave)
          # puts "First time we visited small_cave: #{start_cave} - going to add to visited: #{visited}"
          if !visited.has_key?(start_cave)
            visited[start_cave] = 1
          else
            visited[start_cave] += 1
          end
          puts "Updated small_cave: #{start_cave} in visited: #{visited}"
        end
        puts "Visited is now #{visited}"

        puts "About to do recursive with connecting_cave: #{connecting_cave} - next_path/current_path: #{next_path}"
        build_paths_part2(connecting_cave, next_path, visited, all_paths)
      end
      # puts BANNER
      visited = {}
    end
    all_paths
  end

  def part1
    all_paths = build_paths
    all_paths.size
  end

  def part2

  end

  private

  def small_cave?(cave)
    (cave != cave.upcase) && !["start", "end"].include?(cave)
  end
end


if $PROGRAM_NAME  == __FILE__
  cave_map_conns = CaveMap.build_connections("lib/input.txt")
  cave_map = CaveMap.new(cave_map_conns)
  puts "Answer for part 1: #{CaveMap.from_file("lib/input.txt").build_paths.size}"

  # This spits out the wrong answer, but pasting connections into a test gives right answer
  # puts "Answer for part 1: #{cave_map.part1}"
end

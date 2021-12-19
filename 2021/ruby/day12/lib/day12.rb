class CaveMap
  attr_accessor :connections

  def initialize(connections)
    @connections = connections
  end

  def self.from_file(filepath)
    connections = Hash.new([])
    File.foreach(filepath, chomp: true).map do |line|
      start_cave, end_cave = line.split("-")
      if connections.has_key?(start_cave)
        connections[start_cave].append(end_cave)
      else
        connections[start_cave] = [end_cave]
      end

      if connections.has_key?(end_cave)
        connections[end_cave].append(start_cave)
      else
        connections[end_cave] = [start_cave]
      end
    end
    new(connections)
  end

  def part1

  end

  def part2

  end
end


if $PROGRAM_NAME  == __FILE__
  cave_map = CaveMap.from_file("lib/input.txt")

  puts "Answer for part 1: #{cave_map.part1}"
  puts "Answer for part 2: #{cave_map.part2}"
end

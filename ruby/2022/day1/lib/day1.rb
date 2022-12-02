class ElfInfo

  PART2_ELF_COUNT = 3

  attr_accessor :elf_info

  def initialize(elf_info)
    @elf_info = elf_info
  end

  def self.from_file(filepath)
    raw_content = File.read(filepath, chomp: true).split(/\n\n/)
    new(raw_content.map { |elf| elf.split(/\n/).map(&:to_i) })
  end

  def part1
    biggest = 0
    elf_info.each do |elf|
      if elf.sum > biggest
        biggest = elf.sum
      end
    end
    biggest
  end

  def part2
    elf_info.map { |elf| elf.sum }.sort![-PART2_ELF_COUNT..].reduce(:+)
  end
end

if $PROGRAM_NAME  == __FILE__
  elf_info = ElfInfo.from_file("lib/input.txt")

  part1 = elf_info.part1
  puts "Found #{part1} calories in part 1"

  part2 = elf_info.part2
  puts "Found #{part2} calories in part 2"
end

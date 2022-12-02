class ElfInfo
	attr_accessor :elf_info

  def initialize(elf_info)
    @elf_info = elf_info
  end

  def self.from_file(filepath)
    raw_content = File.read(filepath, chomp: true).split(/\n\n/)
    # puts "raw_content: #{raw_content}"
    elf_info = raw_content.map do |elf|
      elf.split(/\n/).map(&:to_i)
    end

    new(elf_info)
  end

  def part1
    puts "elf_info: #{elf_info}"
    biggest = 0
    elf_info.each do |elf|
      if elf.sum > biggest
        biggest = elf.sum
      end
    end
    biggest
  end
end

if $PROGRAM_NAME  == __FILE__
  elf_info = ElfInfo.from_file("lib/input.txt")

  part1 = elf_info.part1
  puts "Found #{part1} calories in part 1"
end

module Day4
  class PassportList
    attr_accessor :raw_list

    def initialize(raw_list)
      @raw_list = raw_list
    end

    def self.from_file(filepath)
      new(
        File.read(filepath, chomp: true).split(/\n\n/).map do |line|
          line.chomp.gsub(/\n/, " ")
        end
      )
    end

    def count_valid_passports
      @raw_list.reduce(0) do |valid_entries, raw_entry|
        valid_entries + (Part1::Passport.new(raw_entry).valid? ? 1 : 0)
      end
    end
  end

  class Part1
    class Passport
      attr_accessor :raw_entry

      REQUIRED_FIELDS = [
        "byr",
        "iyr",
        "eyr",
        "hgt",
        "hcl",
        "ecl",
        "pid",
      ]
      ALL_FIELDS = REQUIRED_FIELDS + ["cid"]

      def initialize(raw_entry)
        @raw_entry = raw_entry
      end

      def valid?
        REQUIRED_FIELDS.all? { |field| fields.include?(field) }
      end

      private

      def fields
        @raw_entry.split(" ").map { |raw_field| raw_field.split(":") }.to_h
      end
    end
  end

  class Part2
    class Passport
      attr_accessor :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid

      def self.from_raw(raw_entry)
        new(raw_entry.split(" ").map { |raw_field| raw_field.split(":") }.to_h { |k, v| [k.to_sym, v] })
      end

      def initialize(attributes)
        @byr = attributes[:byr]
        @iyr = attributes[:iyr]
        @eyr = attributes[:eyr]
        @hgt = attributes[:hgt]
        @hcl = attributes[:hcl]
        @ecl = attributes[:ecl]
        @pid = attributes[:pid]
      end
    end

    class BirthYear
      def initialize(year)
        @year = year.to_i
      end

      def valid?
        @year >= 1920 && @year <= 2002
      end
    end

    class IssueYear
      def initialize(year)
        @year = year.to_i
      end

      def valid?
        @year >= 2010 && @year <= 2020
      end
    end

    class ExpirationYear
      def initialize(year)
        @year = year.to_i
      end

      def valid?
        @year >= 2020 && @year <= 2030
      end
    end

    class Height
      attr_accessor :height, :units

      def initialize(height, units)
        @height = height
        @units = units
      end

      def self.from_raw(raw_input)
        height = raw_input.match(/^\d+/).to_s.to_i
        units = raw_input.match(/\D{2}$/).to_s
        new(height, units)
      end

      def valid?
        if @units == "in"
          min = 59
          max = 76
        elsif @units == "cm"
          min = 150
          max = 193
        end
        @height >= min && @height <= max
      end
    end

    class HairColor
      attr_accessor :color

      def initialize(color)
        @color = color
      end

      def valid?
        @color.match?(/^#[abcdef0-9]{6}$/)
      end
    end

    class EyeColor
      VALID_COLORS = %w{amb blu brn gry grn hzl oth}

      attr_accessor :color

      def initialize(color)
        @color = color
      end

      def valid?
        VALID_COLORS.include?(@color)
      end
    end

    class PassportId
      attr_accessor :id_number

      def initialize(id_number)
        @id_number = id_number.to_s
      end

      def valid?
        @id_number.match?(/^\d{9}$/)
      end
    end
  end
end


if $PROGRAM_NAME  == __FILE__
  raw_passport_list = Day4::PassportList.from_file("lib/day4_data.txt")

  puts "Answering part 1"
  valid_passports = raw_passport_list.count_valid_passports
  puts "Got #{valid_passports} valid passports"
end

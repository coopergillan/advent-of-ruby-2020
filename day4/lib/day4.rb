module Day4
  class PassportList
    attr_accessor :raw_list

    def initialize(raw_list)
      @raw_list = raw_list
    end

    def self.from_file(filepath)
      new(
        File.read(filepath, chomp: true).split("\n\n").map do |line|
          line.chomp.gsub("\n", " ")
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
        @raw_entry.split(" ").map { |raw_field| jaw_field.split(":").to_h }
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
        puts attributes
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
    end

    class ExpirationYear
    end

    class Height
    end

    class HairColor
    end

    class EyeColor
    end

    class PassportId
    end
  end
end


if $PROGRAM_NAME  == __FILE__
  raw_passport_list = Day4::PassportList.from_file("lib/day4_data.txt")

  puts "Answering part 1"
  valid_passports = raw_passport_list.count_valid_passports
  puts "Got #{valid_passports} valid passports"
end

module Day4
  class PassportList
    attr_accessor :entries

    def initialize(entries)
      @entries = entries
    end

    def self.from_file(filepath)
      new(
        File.read(filepath, chomp: true).split(/\n\n/).map do |line|
          line.chomp.gsub(/\n/, " ")
        end
      )
    end

    def count_valid_passports_part1
      @entries.reduce(0) do |valid_entries, raw_entry|
        valid_entries + (Part1::Passport.new(raw_entry).valid? ? 1 : 0)
      end
    end

    def count_valid_passports_part2
      @entries.reduce(0) do |valid_entries, raw_entry|
        valid_entries + (Part2::Passport.from_raw(raw_entry).valid? ? 1 : 0)
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
    class BirthYear
      def initialize(year)
        @year = year.to_i
      end

      def valid?
        @year.between?(1920, 2002)
      end
    end

    class IssueYear
      def initialize(year)
        @year = year.to_i
      end

      def valid?
        @year.between?(2010, 2020)
      end
    end

    class ExpirationYear
      def initialize(year)
        @year = year.to_i
      end

      def valid?
        @year.between?(2020, 2030)
      end
    end

    class Height
      attr_accessor :height, :units

      def initialize(raw_input)
        if !raw_input.nil?
          matcher = raw_input.match(/(?<height>^\d+)(?<units>(cm|in))/)
          if matcher
            @height = matcher[:height].to_s.to_i
            @units = matcher[:units].to_s
          end
        else
          @height = nil
          @units = nil
        end
      end

      def valid?
        if [@units, @height].all?
          if @units == "in"
            min = 59
            max = 76
          elsif @units == "cm"
            min = 150
            max = 193
          end
          return @height.between?(min, max)
        end
        false
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

    class Passport
      REQUIRED_FIELDS = [
        :byr,
        :iyr,
        :eyr,
        :hgt,
        :hcl,
        :ecl,
        :pid,
      ]
      ATTR_CLASSES = {
        iyr: Part2::IssueYear,
        byr: Part2::BirthYear,
        eyr: Part2::ExpirationYear,
        hgt: Part2::Height,
        hcl: Part2::HairColor,
        ecl: Part2::EyeColor,
        pid: Part2::PassportId,
      }

      attr_accessor :attributes

      def self.from_raw(raw_entry)
        attributes = raw_entry.split(" ").map { |raw_field| raw_field.split(":") }.to_h { |k, v| [k.to_sym, v] }
        new(attributes)
      end

      def initialize(attributes)
        @attributes = attributes
      end

      def valid?
        REQUIRED_FIELDS.map do |req_field|
          if (input_value = @attributes[req_field])
            ATTR_CLASSES[req_field].new(input_value).valid?
          end
        end.all?
      end
    end
  end
end


if $PROGRAM_NAME  == __FILE__
  raw_passport_list = Day4::PassportList.from_file("lib/day4_data.txt")

  puts "Answering part 1"
  valid_passports = raw_passport_list.count_valid_passports_part1
  puts "Got #{valid_passports} valid passports"

  puts "Answering part 2"
  valid_passports = raw_passport_list.count_valid_passports_part2
  puts "Got #{valid_passports} valid passports"
end

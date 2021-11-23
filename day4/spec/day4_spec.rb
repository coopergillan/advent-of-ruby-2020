require "day4"

describe Day4 do
  describe Day4::PassportList do
    subject { described_class.from_file("spec/day4_test_input.txt") }

    context "#from_file" do
      it "converts a file path to an array of raw passport strings" do
        expect(subject.raw_list.size).to eq(4)
        expect(subject.raw_list).to match_array([
          "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm",
          "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884 hcl:#cfa07d byr:1929",
          "hcl:#ae17e1 iyr:2013 eyr:2024 ecl:brn pid:760753108 byr:1931 hgt:179cm",
          "hcl:#cfa07d eyr:2025 pid:166559648 iyr:2011 ecl:brn hgt:59in",
        ])
      end
    end

    context "#count_valid_passports" do
      it "counts the valid passports" do
        expect(subject.count_valid_passports).to eq(2)
      end
    end
  end

  describe Day4::Part1::Passport do
    it "marks passports with all eight fields as valid" do
    expect(
      described_class.new(
        "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm"
      ).valid?).to be(true)
    end

    it "marks passports with all fields except the cid field as valid" do
      expect(
        described_class.new(
          "hcl:#ae17e1 iyr:2013 eyr:2024 ecl:brn pid:760753108 byr:1931 hgt:179cm",
        ).valid?).to be(true)
    end

    it "marks passports missing the required fields as invalid" do
      expect(
        described_class.new(
          "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884 hcl:#cfa07d byr:1929",
        ).valid?).to be(false)
    end
  end

  describe Day4::Part2::Passport do
    context "#from_raw" do
      it "instantiates all attributes with raw entry" do
        raw_entry = "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm"
        passport = described_class.from_raw(raw_entry)
        expect(passport).to have_attributes(
          byr: "1937",
          iyr: "2017",
          eyr: "2020",
          hgt: "183cm",
          hcl: "#fffffd",
          ecl: "gry",
          pid: "860033327",
        )
      end
    end
  end

  describe "Part 2 attribute classes" do
    context Day4::Part2::BirthYear do
      it "accepts a string and returns true for a BirthYear in the given range" do
        birth_year = described_class.new("1937")
        expect(birth_year.valid?).to be(true)
      end

      it "accepts a string and returns true for a BirthYear on the edge of the given range" do
        birth_year = described_class.new("1920")
        expect(birth_year.valid?).to be(true)
      end

      it "accepts a string and returns false for a BirthYear outside the given range" do
        birth_year = described_class.new("2003")
        expect(birth_year.valid?).to be(false)
      end
    end

    context Day4::Part2::IssueYear do
      it "accepts a string and returns true for an IssueYear in the given range" do
        issue_year = described_class.new("2014")
        expect(issue_year.valid?).to be(true)
      end

      it "accepts a string and returns true for an IssueYear on the edge of the given range" do
        issue_year = described_class.new("2020")
        expect(issue_year.valid?).to be(true)
      end

      it "accepts a string and returns false for an IssueYear outside the given range" do
        issue_year = described_class.new("2009")
        expect(issue_year.valid?).to be(false)
      end
    end

    context Day4::Part2::ExpirationYear do
      it "accepts a string and returns true for an ExpirationYear in the given range" do
        expiration_year = described_class.new("2025")
        expect(expiration_year.valid?).to be(true)
      end

      it "accepts a string and returns true for an ExpirationYear on the edge of the given range" do
        expiration_year = described_class.new("2030")
        expect(expiration_year.valid?).to be(true)
      end

      it "accepts a string and returns false for a ExpirationYear outside the given range" do
        expiration_year = described_class.new("2019")
        expect(expiration_year.valid?).to be(false)
      end
    end

    context Day4::Part2::Height do
      context "when height given in inches" do
        it "returns true for a value within the range" do
          height = described_class.from_raw("62in")
          expect(height.valid?).to be(true)
        end

        it "returns false for a value outside the range" do
          height = described_class.from_raw("80in")
          expect(height.valid?).to be(false)
        end

        it "returns true for a value at the edge of the range" do
          height = described_class.from_raw("76in")
          expect(height.valid?).to be(true)
        end
      end

      context "when height given in centimeters" do
        it "returns true for a value within the range" do
          height = described_class.from_raw("165cm")
          expect(height.valid?).to be(true)
        end

        it "returns false for a value outside the range" do
          height = described_class.from_raw("140cm")
          expect(height.valid?).to be(false)
        end

        it "returns true for a value at the edge of the range" do
          height = described_class.from_raw("193cm")
          expect(height.valid?).to be(true)
        end
      end
    end

    context Day4::Part2::HairColor do
      it "returns true for a valid hex color" do
        hair_color = described_class.new("#602fce")
        expect(hair_color.valid?).to be(true)
      end

      it "returns false for an invalid hex color" do
        hair_color = described_class.new("#602qrs")
        expect(hair_color.valid?).to be(false)
      end

      it "returns false for non-hex input" do
        hair_color = described_class.new("Brown")
        expect(hair_color.valid?).to be(false)
      end
    end
  end
end

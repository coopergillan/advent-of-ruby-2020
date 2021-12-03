require "day3"

describe DiagnosticReport do
  subject { described_class.from_file("spec/test_input.txt") }
  let(:bits) { [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010",
  ] }

  context "#from_file" do
    it "converts a file path to an array" do
      expect(subject.bits.class).to eq(Array)
      expect(subject.bits).to match_array(bits)
      expect(subject.entry_length).to eq(5)
    end
  end

  it "counts the occurrence of bits at each index" do
    expect(subject.bit_counts(bits)).to include({
      0 => 7,
      1 => 5,
      2 => 8,
      3 => 7,
      4 => 5,
    })
  end

  it "reports the most common bit at each position" do
    expect(subject.most_common_bit_by_position(bits)).to include({
      0 => 1,
      1 => 0,
      2 => 1,
      3 => 1,
      4 => 0,
    })
  end

  context "answering part1" do
    it "gets the binary version of gamma rate using most_common_bit_by_position" do
      expect(subject.gamma_rate_binary).to eq("10110")
    end

    it "gets the gamma rate by converting binary to decimal" do
      expect(subject.gamma_rate).to eq(22)
    end

    it "gets the binary version of epsilon rate using most_common_bit_by_position" do
      expect(subject.epsilon_rate_binary).to eq("01001")
    end

    it "gets the gamma rate by converting binary to decimal" do
      expect(subject.epsilon_rate).to eq(9)
    end

    it "calculates the power consumption by multiplying the gamma and epsilon rates" do
      expect(subject.part1).to eq(22 * 9) # 198
    end
  end

  context "answering part2" do
    it "runs a recursive check for to get the matching Oxygen generator rating binary" do
      expect(subject.recursion_time(bits)).to eq("10111")
    end

    it "finds the oxygen generator rating in binary" do
      expect(subject.oxygen_generator_rating_binary).to eq("10111")
    end

    it "finds the oxygen generator rating in decimal" do
      expect(subject.oxygen_generator_rating).to eq(23)
    end

    it "uses a recursive check to get matching CO2 scrubber rating binary" do
      expect(subject.recursion_time(bits, checking_o2: false)).to eq("01010")
    end

    it "finds CO2 scrubber rating in binary" do
      expect(subject.co2_scrubber_rating_binary).to eq("01010")
    end

    it "finds CO2 scrubber rating in binary" do
      expect(subject.co2_scrubber_rating).to eq(10)
    end

    it "calculates the life support rating by multiplying the oxygen generator rating by the CO2 scrubber rating" do
      expect(subject.life_support_rating).to eq(23 * 10) # 230
    end

    it "gets the answer for part2" do
      expect(subject.part2).to eq(230)
    end
  end
end

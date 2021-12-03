require "day3"

describe DiagnosticReport do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to an array" do
      expect(subject.bits.class).to eq(Array)
      expect(subject.bits).to match_array([
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
      ])
      expect(subject.entry_length).to eq(5)
      expect(subject.report_length).to eq(12)
    end
  end

  it "counts the occurrence of bits at each index" do
    expect(subject.bit_counts).to include({
      0 => 7,
      1 => 5,
      2 => 8,
      3 => 7,
      4 => 5,
    })
  end

  it "gets the binary version of gamma rate using bit_counts" do
    expect(subject.gamma_rate_binary).to eq("10110")
  end

  it "gets the gamma rate by converting binary to decimal" do
    expect(subject.gamma_rate).to eq(22)
  end

  it "gets the binary version of epsilon rate using bit_counts" do
    expect(subject.epsilon_rate_binary).to eq("01001")
  end

  it "gets the gamma rate by converting binary to decimal" do
    expect(subject.epsilon_rate).to eq(9)
  end

  context "#answer_part1" do
    it "calculates the power consumption by multiplying the gamma and epsilon rates" do
      expect(subject.part1).to eq(22 * 9) # 19l
    end
  end
end

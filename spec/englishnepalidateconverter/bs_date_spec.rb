# frozen_string_literal: true

require "spec_helper"

describe EnglishNepaliDateConverter::BSDate do
  let(:described_instance) { described_class.new(2082, 5, 18) }

  it "should be a valid instance" do
    expect(described_instance).to be_a(EnglishNepaliDateConverter::BSDate)
  end

  context "#month_name" do
    subject { described_instance.month_name }

    it "should return a valid month name" do
      expect(subject).to eq("भाद्र")
    end

    context "with romanized option" do
      subject { described_instance.month_name(romanized: true) }

      it "should return a valid month name" do
        expect(subject).to eq("Bhadra")
      end
    end
  end

  context "#to_nepali" do
    subject { described_instance.to_nepali }

    it "should return a valid Nepali number" do
      expect(subject).to eq("भाद्र १८, २०८२")
    end
  end

  context "#day_name" do
    subject { described_instance.day_name }

    it "should return a valid day name" do
      expect(subject).to eq("बुधबार")
    end

    context "with romanized option" do
      subject { described_instance.day_name(romanized: true) }

      it "should return a valid day name" do
        expect(subject).to eq("Budhbar")
      end
    end

    context "with localized option" do
      subject { described_instance.day_name(localized: true) }

      it "should return a valid day name" do
        expect(subject).to eq("Wednesday")
      end
    end
  end

  describe "BS to AD conversion" do
    subject { date.to_ad }

    context "with valid date" do
      let(:date) { BSDate.new(2082, 5, 18) }

      it "should return a valid AD date instance" do
        expect(subject).to be_a(Date)
      end

      it "should return a valid AD date" do
        expect(subject.year).to eq(2025)
        expect(subject.month).to eq(9)
        expect(subject.day).to eq(3)
      end
    end

    context "with invalid date" do
      let(:date) { BSDate.new(1999, 1, 1) }

      it "should raise an error" do
        expect { subject }.to raise_error(BSDateOutOfRangeError)
      end
    end

    context "with no arguments" do
      let(:date) { BSDate.new }

      it "should return a valid AD date instance" do
        expect(subject).to be_a(Date)
      end
    end
  end

  describe "AD to BS conversion" do
    subject { date.to_bs }

    context "with valid date" do
      let(:date) { Date.new(2025, 9, 3) }

      it "should return a valid BS date instance" do
        expect(subject).to be_a(described_class)
      end

      it "should return a valid BS date" do
        expect(subject.year).to eq(2082)
        expect(subject.month).to eq(5)
        expect(subject.day).to eq(18)
      end
    end

    context "with invalid date" do
      let(:date) { Date.new }

      it "should raise an error" do
        expect { subject }.to raise_error(EnglishNepaliDateConverter::DateOutOfRangeError)
      end
    end
  end
end

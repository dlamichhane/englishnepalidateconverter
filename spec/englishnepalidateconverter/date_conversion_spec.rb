# frozen_string_literal: true

require "spec_helper"

# rubocop:disable Metrics/BlockLength

describe EnglishNepaliDateConverter::DateConversion do
  let(:described_instance) { described_class.new }

  describe "from Gregorian to Nepali Calendar" do
    context "invalid day" do
      let(:subject) { described_instance.eng_to_nep(42, 0o1, 2013) }
      it "should return error message" do
        expect(subject).to eq(["Enter appropriate day"])
      end
    end

    context "valid date" do
      let(:subject) { described_instance.eng_to_nep(31, 0o1, 2013) }
      it "should have appropriate days of the month" do
        subject

        expect(subject.day_in_month).to eq(18)
        expect(subject.day_of_week).to eq(5)
        expect(subject.month).to eq("Magh")
        expect(subject.month_number).to eq(10)
        expect(subject.week_day).to eq("Bihibar")
        expect(subject.year).to eq(2069)
      end
    end

    context "invalid month" do
      let(:subject) { described_instance.eng_to_nep(0o1, 41, 2013) }
      it "should return error message" do
        expect(subject).to eq(["Enter appropriate month"])
      end
    end

    context "invalid month" do
      let(:subject) { described_instance.eng_to_nep(0o1, 41, 2013) }
      it "should have appropriate month" do
        expect(subject).to eq(["Enter appropriate month"])
      end
    end

    context "invalid year" do
      let(:subject) { described_instance.eng_to_nep(0o1, 11, 2093) }
      it "should have appropriate year" do
        expect(subject).to eq(["Enter appropriate year"])
      end
    end
  end

  describe "from Nepali Calendar to Gregorian calendar" do
    context "invalid year" do
      let(:subject) { described_instance.nep_to_eng(0o1, 0o1, year_value) }

      context "with less than 2000" do
        let(:year_value) { 1943 }
        it "should return error message" do
          expect(subject).to eq(["Enter appropriate year"])
        end
      end

      context "with more than 2090" do
        let(:year_value) { 3043 }
        it "should return error message" do
          expect(subject).to eq(["Enter appropriate year"])
        end
      end
    end

    context "valid date" do
      let(:subject) { described_instance.nep_to_eng(0o1, 0o1, 2033) }

      context "with valid year" do
        it "converts date range successfully" do
          subject

          expect(subject.year).to eq(1976)
          expect(subject.day_of_week).to eq(3)
          expect(subject.month).to eq("April")
          expect(subject.day_in_month).to eq(13)
          expect(subject.month_number).to eq(4)
          expect(subject.week_day).to eq("Tuesday")
        end
      end
    end

    context "invalid day" do
      let(:subject) { described_instance.nep_to_eng(42, 12, 2001) }

      it "should return error message" do
        expect(subject).to eq(["Enter appropriate day"])
      end
    end

    context "invalid month" do
      let(:subject) { described_instance.nep_to_eng(12, 14, 2013) }
      it "should return error message" do
        expect(subject).to eq(["Enter appropriate month"])
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength

# frozen_string_literal: true

require_relative "bs_calendar"

module EnglishNepaliDateConverter
  # Base BS Date class
  class BSDate
    include BSCalendar

    attr_reader :year, :month, :day

    def initialize(year = nil, month = nil, day = nil)
      if year && month && day
        @year = year
        @month = month
        @day = day
      else
        # No arguments provided, use current AD date and convert to BS
        bs = BSDate.from_ad(Date.today)
        @year = bs.year
        @month = bs.month
        @day = bs.day
      end
    end

    def to_nepali
      "#{month_name} #{day.to_nepali}, #{year.to_nepali}"
    end

    # Convert Bikram Sambat date to Anno Domini (Gregorian) date
    def to_ad
      validate_date!
      Date.jd(bs_to_jd(@year, @month, @day))
    end

    # Convert Anno Domini (Gregorian) date to Bikram Sambat date
    def self.from_ad(ad_date)
      year, month, day = jd_to_bs(ad_date.jd)
      new(year, month, day)
    end

    def month_name(romanized: false)
      romanized ? MONTHS.values[@month - 1] : MONTHS.keys[@month - 1]
    end

    def day_name(romanized: nil, localized: nil)
      if [romanized, localized].reject { |v| v.nil? || v == false }.size > 1
        raise ArgumentError, "You must provide exactly one of :romanized or :localized"
      end

      ad_date = to_ad

      return WEEKDAYS.values[ad_date.wday] if romanized
      return Date::DAYNAMES[ad_date.wday] if localized

      WEEKDAYS.keys[ad_date.wday]
    end

    private

    def validate_date!
      return if valid_date?

      raise BSDateOutOfRangeError,
            "Year #{year} is out of valid range (#{MONTH_DAYS.keys.first}-#{MONTH_DAYS.keys.last})"
    end

    def valid_date?
      MONTH_DAYS.key?(year) && (1..12).include?(month) && (1..MONTH_DAYS[year][month - 1]).include?(day)
    end

    def bs_to_jd(year, month, day)
      julian_day = EPOCH_JD

      # Add days from complete years
      (EPOCH_BS[0]...year).each do |year_index|
        julian_day += MONTH_DAYS[year_index].sum
      end

      # Add days from complete months in the current year
      julian_day += MONTH_DAYS[year][0...(month - 1)].sum

      # Add remaining days
      julian_day += (day - 1)

      julian_day
    end

    def self.jd_to_bs(julian_day)
      year = EPOCH_BS[0]
      remaining_days = julian_day - EPOCH_JD

      # Find the correct year by subtracting complete years
      while remaining_days >= MONTH_DAYS[year].sum
        remaining_days -= MONTH_DAYS[year].sum
        year += 1
      end

      # Find the correct month and day within the year
      month = 1
      MONTH_DAYS[year].each do |days_in_month|
        break if remaining_days < days_in_month

        remaining_days -= days_in_month
        month += 1
      end

      [year, month, remaining_days + 1]
    end
  end
end

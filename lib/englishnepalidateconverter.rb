# frozen_string_literal: true

$LOAD_PATH << File.dirname(__FILE__)

require_relative "englishnepalidateconverter/version"
require "date"
require_relative "englishnepalidateconverter/bs_date"
require_relative "englishnepalidateconverter/bs_calendar"
require_relative "englishnepalidateconverter/extensions/date"
require_relative "englishnepalidateconverter/extensions/integer"

module EnglishNepaliDateConverter
  class Error < StandardError; end

  # Date out of range error
  class DateOutOfRangeError < Error
    def initialize(message = "Date out of range")
      super(message)
    end
  end

  # BS Date out of range error
  class BSDateOutOfRangeError < Error
    def initialize(message = "BS Date out of range")
      super(message)
    end
  end
end

BSDate = EnglishNepaliDateConverter::BSDate
DateOutOfRangeError = EnglishNepaliDateConverter::DateOutOfRangeError
BSDateOutOfRangeError = EnglishNepaliDateConverter::BSDateOutOfRangeError

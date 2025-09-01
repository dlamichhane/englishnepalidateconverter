# frozen_string_literal: true

$LOAD_PATH << File.dirname(__FILE__)

require "englishnepalidateconverter/version"
require "date"
require "englishnepalidateconverter/constants"
require "englishnepalidateconverter/bs_date"
require "englishnepalidateconverter/date_conversion"

# date = EnglishNepaliDateConverter::DateConversion.new
# date.nep_to_eng(01, 01, 2033)
# date.eng_to_nep(42, 12, 2001)

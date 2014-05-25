$LOAD_PATH << File.dirname(__FILE__)

require "english_nepali_date_converter/version"
require "date"
require "english_nepali_date_converter/constants"
require "english_nepali_date_converter/bs_date"
require "english_nepali_date_converter/date_conversion"

call = EnglishNepaliDateConverter::DateConversion.new
# call.nep_to_eng(24, 05, 2041)
call.eng_to_nep(19, 09, 1984)

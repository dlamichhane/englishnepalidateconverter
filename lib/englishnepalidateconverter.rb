$LOAD_PATH << File.dirname(__FILE__)

require "englishnepalidateconverter/version"
require "date"
require "englishnepalidateconverter/constants"
require "englishnepalidateconverter/bs_date"
require "englishnepalidateconverter/date_conversion"

date = EnglishNepaliDateConverter::DateConversion.new
# date.nep_to_eng(12, 02, 2041)
p date.eng_to_nep("09", "09", 1984)

require 'spec_helper'

describe "Date Conversion" do
	context "from Gregorian to Nepali Calendar" do
		it "should convert date range only from 01-01-1944 to 31-12-2033" do
			call = EnglishNepaliDateConverter::DateConversion.new
			call.eng_to_nep(01, 01, 1943).should == "Enter a valid date from 01-01-1944 to 31-12-2033"
			call.eng_to_nep(01, 01, 2043).should == "Enter a valid date from 01-01-1944 to 31-12-2033"
			call.eng_to_nep(01, 01, 2033)
			call.year.should == 2089
			call.day_of_week.should == 7
			call.month.should == "Poush"
			call.day_in_month.should == 17
			call.month_number.should == 9
			call.week_day.should == "Sanibar"
		end

		it "should have appropriate days of the month" do
			call  = EnglishNepaliDateConverter::DateConversion.new
			call.eng_to_nep(33, 01, 2013).should == "Enter appropriate day of the month"
			call.eng_to_nep(-2, 01, 2013).should == "Enter appropriate day of the month"
			call.eng_to_nep(31, 01, 2013)
			call.day_in_month.should == 18
			call.day_of_week.should == 5
			call.month.should == "Magh"
			call.month_number.should == 10
			call.week_day.should == "Bihibar"
			call.year.should == 2069
		end

		it "should have appropriate month" do
			call  = EnglishNepaliDateConverter::DateConversion.new
			call.eng_to_nep(01, 41, 2013).should == "Enter appropriate month"
			call.eng_to_nep(01, 00, 2013).should == "Enter appropriate month"
			call.eng_to_nep(01, 01, 2013)
			call.day_in_month.should == 17
			call.day_of_week.should == 3
			call.month.should == "Poush"
			call.month_number.should == 9
			call.week_day.should == "Mangalbar"
			call.year.should == 2069
		end

		it "should have appropriate year" do
			call  = EnglishNepaliDateConverter::DateConversion.new
			call.eng_to_nep(01, 11, 2093).should == "Enter a valid date from 01-01-1944 to 31-12-2033"
			call.eng_to_nep("01", "01", "2013")
			call.day_in_month.should == 17
			call.day_of_week.should == 3
			call.month.should == "Poush"
			call.month_number.should == 9
			call.week_day.should == "Mangalbar"
			call.year.should == 2069
		end
	end

	context "from Nepali Calendar to Gregorian calendar" do
		it "should convert date range only from 01-01-2000 to 30-12-2090" do
			call = EnglishNepaliDateConverter::DateConversion.new
			call.nep_to_eng(01, 01, 1943).should == "Enter appropriate year"
			call.nep_to_eng(01, 01, 3043).should == "Enter appropriate year"
			call.nep_to_eng(01, 01, 2033)
			call.year.should == 1976
			call.day_of_week.should == 3
			call.month.should == "April"
			call.day_in_month.should == 13
			call.month_number.should == 4
			call.week_day.should == "Tuesday"
		end

		it "should have appropriate days of the month" do
			b  = EnglishNepaliDateConverter::DateConversion.new
			puts b.nep_to_eng(22, 12, 2000)
			# b.nep_to_eng(22, 12, 2000).should == "Enter appropriate day of the month"
			# call.nep_to_eng(22, 01, 2000).should == "Enter appropriate day of the month"
			# call.nep_to_eng(31, 01, 2013)
			# call.day_in_month.should == 18
			# call.day_of_week.should == 5
			# call.month.should == "Magh"
			# call.month_number.should == 10
			# call.week_day.should == "Bihibar"
			# call.year.should == 2069
		end

		xit "should have appropriate month" do
			call  = EnglishNepaliDateConverter::DateConversion.new
			call.nep_to_eng(12, -1, 2013).should == "Enter appropriate month"
			call.nep_to_eng(12, 14, 2013).should == "Enter appropriate month"
			call.nep_to_eng(12, 01, 2013)
			call.day_in_month.should == 18
			call.day_of_week.should == 5
			call.month.should == "Magh"
			call.month_number.should == 10
			call.week_day.should == "Bihibar"
			call.year.should == 2069
		end
	end
end
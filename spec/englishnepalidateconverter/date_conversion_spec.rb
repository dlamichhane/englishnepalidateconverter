require 'spec_helper'

describe "Date Conversion" do
	before(:each) do
	  @date = EnglishNepaliDateConverter::DateConversion.new
	end

	context "from Gregorian to Nepali Calendar" do
		it "should have appropriate days of the month" do
			@date.eng_to_nep(42, 01, 2013).should == ["Enter appropriate day"]
			@date.eng_to_nep(31, 01, 2013)
			@date.day_in_month.should == 18
			@date.day_of_week.should == 5
			@date.month.should == "Magh"
			@date.month_number.should == 10
			@date.week_day.should == "Bihibar"
			@date.year.should == 2069
		end

		it "should have appropriate month" do
			@date.eng_to_nep(01, 41, 2013).should == ["Enter appropriate month"]
			@date.eng_to_nep(01, 00, 2013).should == ["Enter appropriate month"]
			@date.eng_to_nep(01, 01, 2013)
			@date.day_in_month.should == 17
			@date.day_of_week.should == 3
			@date.month.should == "Poush"
			@date.month_number.should == 9
			@date.week_day.should == "Mangalbar"
			@date.year.should == 2069
		end

		it "should have appropriate year" do
			@date.eng_to_nep(01, 11, 2093).should == ["Enter appropriate year"]
			@date.eng_to_nep("01", "01", "2013")
			@date.day_in_month.should == 17
			@date.day_of_week.should == 3
			@date.month.should == "Poush"
			@date.month_number.should == 9
			@date.week_day.should == "Mangalbar"
			@date.year.should == 2069
		end
	end

	context "from Nepali Calendar to Gregorian calendar" do
		it "should convert date range only from 01-01-2000 to 30-12-2090" do
			@date.nep_to_eng(01, 01, 1943).should == ["Enter appropriate year"]
			@date.nep_to_eng(01, 01, 3043).should == ["Enter appropriate year"]
			@date.nep_to_eng(01, 01, 2033)
			@date.year.should == 1976
			@date.day_of_week.should == 3
			@date.month.should == "April"
			@date.day_in_month.should == 13
			@date.month_number.should == 4
			@date.week_day.should == "Tuesday"
		end

		it "should have appropriate days of the month" do
			@date.nep_to_eng(42, 12, 2001).should == ["Enter appropriate day"]
			@date.nep_to_eng(12, 01, 2013)
			@date.day_in_month.should == 24
			@date.day_of_week.should == 3
			@date.month.should == "April"
			@date.month_number.should == 4
			@date.week_day.should == "Tuesday"
			@date.year.should == 1956
		end

		it "should have appropriate month" do
			@date.nep_to_eng(12, 00, 2013).should == ["Enter appropriate month"]
			@date.nep_to_eng(12, 14, 2013).should == ["Enter appropriate month"]
			@date.nep_to_eng(12, 11, 2013)
			@date.day_in_month.should == 23
			@date.day_of_week.should == 7
			@date.month.should == "February"
			@date.month_number.should == 2
			@date.week_day.should == "Saturday"
			@date.year.should == 1957
		end
	end
end
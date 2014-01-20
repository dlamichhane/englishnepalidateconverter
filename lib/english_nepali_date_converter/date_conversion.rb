module EnglishNepaliDateConverter

	class DateConversion
		attr_accessor :year, :month, :day_in_month, :day_of_week, :week_day, :month_number

		EN_DAY = { 1 => "Sunday", 2 => "Monday", 3 => "Tuesday", 4 => "Wednesday", 5 => "Thursday", 6 => "Friday", 7 => "Saturday" }
		NP_DAY = { 1 => "Aaitabar", 2 => "Sombar", 3 => "Mangalbar", 4 => "Budhabar", 5 => "Bihibar", 6 => "Sukrabar", 7 => "Sanibar" }

		NP_MONTH = { 1 => "Baisakh",	2 => "Jestha", 3 => "Asar", 4 => "Shrawan",	5 => "Bhadra", 6 => "Ashoj",
			7 => "Kartik", 8 => "Mangsir",	9 => "Poush", 10 => "Magh", 11 => "Falgun", 12 => "Chaitra"	}

		EN_MONTH = { 1 => "January", 2 => "February", 3 => "March", 4 => "April", 5 => "May", 6 => "June",
			7 => "July", 8 => "August", 9 => "September", 10 => "October", 11 => "November", 12 => "December" }

		def eng_to_nep(*args)

			# Normal days in month except leap year
			enDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
			return "Enter appropriate month" unless (1..12).include?(args[1])

			if Date.leap?(args[2].to_i)
				return "Enter appropriate day of the month" unless (1.. + enDaysInMonth[args[1].to_i - 1] + 1).include?(args[0])
			else
				return "Enter appropriate day of the month" unless (1.. + enDaysInMonth[args[1].to_i - 1]).include?(args[0])
			end

			formated_date = args[0].to_s + "-" + args[1].to_s + "-" + args[2].to_s
			starting_date = DateTime.parse("01-01-1944").mjd.to_i
			ending_date = DateTime.parse("31-12-2033").mjd
			date_to_convert = DateTime.parse(formated_date).mjd
			return "Enter a valid date from 01-01-1944 to 31-12-2033" unless (starting_date..ending_date).include?(date_to_convert)

			enTotalDays = date_to_convert - starting_date

			# Conversion of 01-01-1944 AD will be 17.01.2000  BS. Take this BS as a base date
			@year = npStartYear = 2000
			@month_number = npStartMth = 9
			@day_in_month = npStartDay = 17

			startingIndexOfBSDate = 0
			@day_of_week = 7 # Saturday as Day 7 and Sunday as Day 1 of the week

			while enTotalDays !=0
				@day_in_month += 1
				@day_of_week += 1

				if @day_in_month > BsDate::BS_DATES[startingIndexOfBSDate][npStartMth]
					@month_number += 1
					@day_in_month = 1
					npStartMth += 1
				end

				@day_of_week = 1 if @day_of_week > 7

				if @month_number > 12
					@year += 1
					@month_number = 1
				end

				if npStartMth > 12
					npStartMth = 1
					startingIndexOfBSDate += 1
				end

				enTotalDays -= 1
			end

			@week_day = self.class.get_day_of_week(@day_of_week, 'np')
			@month = self.class.get_month_name(@month_number, 'np')
			return self
		end

		def nep_to_eng(*args)

			return "Enter appropriate month" unless (1..12).include?(args[1])

			check_year = []
			for i in 0..90
				check_year << BsDate::BS_DATES[i][0]
			end

			return "Enter appropriate year" unless check_year.index(args[2])

			return "Enter appropriate day of the month" if BsDate::BS_DATES[check_year.index(args[2])][args[1]] < args[0]

			enStartYear = 1943;	enStartMonth = 4; enStartDay = 14 - 1

			npStartYear = 2000;	npStartMth = 1;	npStartDay = 1

			@day_of_week = 4 - 1
			# (2000..2089).include?(args[2]) && (01..12).include?(args[1]) && (01..32).include?(args[0])
			# 2000-01-01 to 2089-12-32
			enDaysInMonth = [0,31,28,31,30,31,30,31,31,30,31,30,31]
			leapEnDaysInMonth = [0,31,29,31,30,31,30,31,31,30,31,30,31]

			npYearDiff = args[2] - npStartYear - 1
			npTotalDays = 0

			for i in 0.. + npYearDiff
				 BsDate::BS_DATES[i].shift
				 npTotalDays += BsDate::BS_DATES[i].inject(:+)
			end

			npMonthDiff = args[1] -1

			for i in 1.. + npMonthDiff
				npTotalDays += BsDate::BS_DATES[args[2] - npStartYear][i]
			end

			npTotalDays += args[0]

			@day_in_month = enStartDay
			@month_number = enStartMonth;
			@year = enStartYear;

			while npTotalDays != 0

				total_month_days = Date.leap?(year) ? leapEnDaysInMonth[@month_number] : enDaysInMonth[@month_number]

				@day_in_month += 1
				@day_of_week += 1

				if @day_in_month > total_month_days
					@month_number += 1
					@day_in_month = 1

					if @month_number > 12
						@year += 1
						@month_number = 1
					end
				end

				@day_of_week = 1 if @day_of_week > 7
				npTotalDays -= 1
			end
			@week_day = self.class.get_day_of_week(@day_of_week, 'en')
			@month = self.class.get_month_name(@month_number, 'en')
			return self
		end

		def self.get_day_of_week(day, type)
			type == "en" ? self::EN_DAY[day] : self::NP_DAY[day]
		end

		def self.get_month_name(month, type)
			type == "en" ? self::EN_MONTH[month] : self::NP_MONTH[month]
		end
	end

end

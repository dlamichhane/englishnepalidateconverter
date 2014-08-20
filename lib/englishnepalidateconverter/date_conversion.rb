module EnglishNepaliDateConverter

  class DateConversion
    attr_accessor :year, :month, :day_in_month, :day_of_week, :week_day, :month_number

    def eng_to_nep(*args)
      args.collect!{|i| i.to_i}
      date_error = date_valid(args, "en")

      unless date_error.empty?
        return date_error.collect{ |error| "Enter appropriate #{error}"}
      else
        formatted_date = args[0].to_s + "-" + args[1].to_s + "-" + args[2].to_s
        starting_date = DateTime.parse("01-01-1944").mjd.to_i
        date_to_convert = DateTime.parse(formatted_date).mjd
        en_total_days = date_to_convert - starting_date
        year = np_start_year = 2000; month_number = np_start_month = 9; day_in_month = np_start_day = 17

        starting_index_of_bs_date = 0; day_of_week = 7 # Saturday as Day 7 and Sunday as Day 1 of the week

        while en_total_days !=0
          day_in_month += 1; day_of_week += 1
          (month_number += 1; day_in_month = 1; np_start_month += 1) if day_in_month > BsDate::BS_DATES[starting_index_of_bs_date][np_start_month]
          day_of_week = 1 if day_of_week > 7
          (year += 1; month_number = 1) if month_number > 12
          (np_start_month = 1;  starting_index_of_bs_date += 1) if np_start_month > 12
          en_total_days -= 1
        end

        self.week_day = get_day_of_week(day_of_week, 'np')
        self.month = get_month_name(month_number, 'np')
        self.month_number = month_number
        self.day_in_month = day_in_month
        self.day_of_week = day_of_week
        self.year = year
        self
      end
    end

    def date_valid(date, state)
      state == "np" ? np_date_valid(date) : en_date_valid(date)
    end

    def np_date_valid(date)
      invalid = []
      year = (0..90).collect {|year| BsDate::BS_DATES[year][0]}
      invalid << "month" unless (1..12).include?(date[1])
      invalid << "year" unless year.index(date[2])
      invalid << "day" if invalid.empty? && BsDate::BS_DATES[year.index(date[2])][date[1]] < date[0]
      invalid
    end

    def en_date_valid(date)
      invalid = []
      # Normal days in month except leap year
      en_days_in_month = [31,28,31,30,31,30,31,31,30,31,30,31]
      invalid << "month" unless (1..12).include?(date[1])
      invalid << "year" unless (1944..2033).include?(date[2])

      if invalid.empty?
        if Date.leap?(date[2].to_i)
          invalid << "day" unless (1..en_days_in_month[date[1].to_i - 1] + 1).include?(date[0])
        else
          invalid << "day" unless (1..en_days_in_month[date[1].to_i - 1]).include?(date[0])
        end
      end

      invalid
    end

    def nep_to_eng(*args)
      args.collect!{|i| i.to_i}
      date_error = date_valid(args, "np")

      unless date_error.empty?
        return date_error.collect{ |error| "Enter appropriate #{error}"}
      else
        en_start_year = 1943; en_start_month = 4; en_start_day = 14 - 1
        np_start_year = 2000; np_start_month = 1; np_start_day = 1
        day_of_week = 4 - 1
        en_days_in_month = [0,31,28,31,30,31,30,31,31,30,31,30,31]
        leap_en_days_in_month = [0,31,29,31,30,31,30,31,31,30,31,30,31]
        np_year_diff = args[2] - np_start_year - 1; np_total_days = 0

        (0..np_year_diff).each do |idx|
          BsDate::BS_DATES[idx].shift
          np_total_days += BsDate::BS_DATES[idx].inject(:+)
        end

        np_month_diff = args[1] - 1
        (1..np_month_diff).each{| idx| np_total_days += BsDate::BS_DATES[args[2] - np_start_year][idx] }

        np_total_days += args[0]
        day_in_month = en_start_day; month_number = en_start_month; year = en_start_year

        while np_total_days != 0
          total_month_days = Date.leap?(year) ? leap_en_days_in_month[month_number] : en_days_in_month[month_number]
          day_in_month += 1; day_of_week += 1

          if day_in_month > total_month_days
            month_number += 1; day_in_month = 1
            (year += 1; month_number = 1) if month_number > 12
          end

          day_of_week = 1 if day_of_week > 7
          np_total_days -= 1
        end

        self.week_day = get_day_of_week(day_of_week, 'en')
        self.month = get_month_name(month_number, 'en')
        self.month_number = month_number
        self.day_in_month = day_in_month
        self.day_of_week = day_of_week
        self.year = year
        self
      end

    end

    def get_day_of_week(day, type)
      type == "en" ? ::EN_DAY[day] : ::NP_DAY[day]
    end

    def get_month_name(month, type)
      type == "en" ? ::EN_MONTH[month] : ::NP_MONTH[month]
    end
  end

end

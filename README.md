# EnglishNepaliDateConverter

This EnglishNepaliDateConverter gem converts between Anno Domini (AD/Gregorian) and Bikram Sambat (BS/Nepali) dates.

**Supported date ranges:**

- AD to BS: 1943-04-14 to 2034-04-13
- BS to AD: 2000-01-01 to 2090-12-30

## Installation

Add this line to your application's Gemfile:

    gem 'englishnepalidateconverter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install englishnepalidateconverter

## Usage

### Basic Date Conversion

```ruby
require 'englishnepalidateconverter'

# Create a BS date from year, month, day
bs_date = BSDate.new(2070, 10, 3)
puts bs_date.to_ad  # => 2014-01-16

# Create a BS date from an AD date
bs_date = BSDate.from_ad(Date.new(2014, 1, 16))
puts "#{bs_date.year}-#{bs_date.month}-#{bs_date.day}"  # => 2070-10-3

# Create current BS date (no arguments)
current_bs = BSDate.new
puts current_bs.to_ad
```

### Using Date Extensions

```ruby
# Convert AD date to BS using Date extension
ad_date = Date.new(2014, 1, 16)
bs_date = ad_date.to_bs
puts "#{bs_date.year}-#{bs_date.month}-#{bs_date.day}"  # => 2070-10-3
```

### Nepali Text Formatting

```ruby
bs_date = BSDate.new(2070, 10, 3)

# Get month name in Nepali
puts bs_date.month_name  # => "मंसिर"

# Get month name in romanized form
puts bs_date.month_name(romanized: true)  # => "Mangsir"

# Get day name in Nepali
puts bs_date.day_name  # => "बुधबार"

# Get day name in romanized form
puts bs_date.day_name(romanized: true)  # => "Budhbar"

# Get day name in English
puts bs_date.day_name(localized: true)  # => "Wednesday"

# Get formatted Nepali date string
puts bs_date.to_nepali  # => "मंसिर ३, २०७०"
```

### Integer Extensions for Nepali Numbers

```ruby
# Convert numbers to Nepali digits
puts 2070.to_nepali  # => "२०७०"
puts 16.to_nepali    # => "१६"
```

## License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details.

Copyright (c) 2014 dlamichhane

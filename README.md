# EnglishNepaliDateConverter

This EnglishNepaliDateConverter gem converts the AD to BS date between 01-01-1944 to 31-12-2033
and BS to AD date between 01-01-2000 to 30-12-2090

## Installation

Add this line to your application's Gemfile:

    gem 'englishnepalidateconverter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install englishnepalidateconverter

## Usage


```ruby
date = EnglishNepaliDateConverter::DateConversion.new
date.eng_to_nep(16,01,2014)
date.nep_to_eng(03,10,2070)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

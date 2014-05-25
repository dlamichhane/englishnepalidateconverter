# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'english_nepali_date_converter/version'

Gem::Specification.new do |spec|
  spec.name          = "english_nepali_date_converter"
  spec.version       = EnglishNepaliDateConverter::VERSION
  spec.date          = %{2014-01-16}
  spec.authors       = ["dlamichhane"]
  spec.email         = ["dlamichhane@hotmail.com"]
  spec.description   = %q{"Conversion of Gregorian calendar to Nepali Calendar"}
  spec.summary       = %q{Converts the English calendar date to Nepali calendar date}
  spec.homepage      = %q{https://github.com/dlamichhane/english_nepali_date_converter}
  spec.licenses         = ['MIT']

  spec.add_development_dependency "rspec"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end

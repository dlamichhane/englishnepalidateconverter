# frozen_string_literal: true

require "English"
lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "englishnepalidateconverter/version"

Gem::Specification.new do |spec|
  spec.name          = "englishnepalidateconverter"
  spec.version       = EnglishNepaliDateConverter::VERSION
  spec.date          = %(2025-09-01)
  spec.authors       = ["dlamichhane"]
  spec.email         = ["lamichhanedeepak@gmail.com"]
  spec.description   = "Conversion of Gregorian calendar to Nepali Calendar"
  spec.summary       = "Converts the English calendar date to Nepali calendar date"
  spec.homepage      = "https://github.com/dlamichhane/englishnepalidateconverter"
  spec.licenses = ["MIT"]

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.7"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.8"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"

  spec.required_ruby_version = ">= 3.4"
end

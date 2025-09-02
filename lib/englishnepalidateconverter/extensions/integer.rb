# frozen_string_literal: true

# Extension to Integer class to add Nepali number method
class Integer
  NEPALI_DIGITS = {
    "0" => "०",
    "1" => "१",
    "2" => "२",
    "3" => "३",
    "4" => "४",
    "5" => "५",
    "6" => "६",
    "7" => "७",
    "8" => "८",
    "9" => "९"
  }.freeze

  def to_nepali
    to_s.chars.map { |c| NEPALI_DIGITS[c] || c }.join
  end
end

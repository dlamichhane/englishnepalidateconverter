# frozen_string_literal: true

require "date"
require_relative "../bs_date"

# Extension to Ruby's Date class to add Bikram Sambat conversion methods
class Date
  EPOCH_AD_START = Date.new(1943, 4, 14)
  EPOCH_AD_END   = Date.new(2034, 4, 13)
  private_constant :EPOCH_AD_START, :EPOCH_AD_END

  def to_bs
    if self < EPOCH_AD_START || self > EPOCH_AD_END
      raise DateOutOfRangeError,
            "Date #{self} is out of supported AD Range (1943-04-14 - 2034-04-13)"
    end

    BSDate.from_ad(self)
  end
end

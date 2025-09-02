# frozen_string_literal: true

RSpec.describe EnglishNepaliDateConverter do
  it "should be a valid version" do
    expect(EnglishNepaliDateConverter::VERSION).to eq("1.0.0")
  end
end

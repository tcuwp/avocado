# frozen_string_literal: true

RSpec.describe Avocado do
  it "has a version number" do
    expect(Avocado::VERSION).not_to be nil
  end
end

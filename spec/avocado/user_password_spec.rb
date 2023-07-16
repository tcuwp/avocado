# frozen_string_literal: true

RSpec.describe Avocado::UserPassword, type: :model do
  subject { User.new }

  describe "Validations" do
    describe "Format" do
      it { is_expected.not_to allow_value("!@#$%^&*").for(:password) }
      it { is_expected.not_to allow_value("12341234").for(:password) }
      it { is_expected.not_to allow_value("TestTest").for(:password) }
      it { is_expected.to allow_value("Test.1234").for(:password) }
    end

    describe "Length" do
      it { is_expected.to validate_length_of(:password).is_at_least(Avocado::UserPassword::REQUIRED_LENGTH) }
    end

    describe "Presence" do
      it { is_expected.to validate_presence_of(:password) }
    end
  end
end

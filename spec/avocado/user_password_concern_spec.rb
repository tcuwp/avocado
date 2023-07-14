# frozen_string_literal: true

RSpec.describe Avocado::UserPasswordConcern, type: :model do
  subject { User.new }

  describe "Validations" do
    describe "Format" do
      it { is_expected.not_to allow_value("!@#$%^&*").for(:password) }
      it { is_expected.not_to allow_value("12341234").for(:password) }
      it { is_expected.not_to allow_value("TestTest").for(:password) }
      it { is_expected.to allow_value("Test.1234").for(:password) }
    end

    describe "Length" do
      it { is_expected.to validate_length_of(:password).is_at_least(Avocado::UserPasswordConcern::REQUIRED_LENGTH) }
    end

    describe "Presence" do
      it { is_expected.to validate_presence_of(:password) }
    end
  end

  describe "Recovery" do
    it "Finds the user with a generated signed id" do
      user = create(:user)
      signed_id = user.generate_token_for(:password_recovery)

      user_from_signed_id = User.find_by_token_for!(:password_recovery, signed_id)

      expect(user_from_signed_id).to eq(user)
    end

    it "Does not finds the user with a generated signed id after expiration" do
      user = create(:user)
      signed_id = user.generate_token_for(:password_recovery)

      travel_to expiration_time

      expect { User.find_by_token_for!(:password_recovery, signed_id) }
        .to raise_error(ActiveSupport::MessageVerifier::InvalidSignature)
    end

    private

    def expiration_time
      Avocado::UserPasswordConcern::TOKEN_EXPIRATION.from_now + 2.minutes
    end
  end
end

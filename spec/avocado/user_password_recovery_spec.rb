# frozen_string_literal: true

RSpec.describe Avocado::UserPasswordRecovery, type: :model do
  subject { User.new }

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
      Avocado::UserPasswordRecovery::TOKEN_EXPIRATION.from_now + 2.minutes
    end
  end
end

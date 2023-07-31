RSpec.describe Avocado::UserTokens do
  describe "Email affirmation" do
    it "Finds the user with a generated signed id" do
      user = create(:user)
      signed_id = user.generate_token_for(:email_affirmation)

      user_from_signed_id = User.find_by_token_for!(:email_affirmation, signed_id)

      expect(user_from_signed_id).to eq(user)
    end

    it "Does not finds the user with a generated signed id after expiration" do
      user = create(:user)
      signed_id = user.generate_token_for(:email_affirmation)

      travel_to email_affirmation_expiration_time

      expect { User.find_by_token_for!(:email_affirmation, signed_id) }
        .to raise_error(ActiveSupport::MessageVerifier::InvalidSignature)
    end

    private

    def email_affirmation_expiration_time
      Avocado::UserTokens::EXPIRES_FAST.from_now + 2.minutes
    end
  end

  describe "Email verification" do
    it "Finds the user with a generated signed id" do
      user = create(:user)
      signed_id = user.generate_token_for(:email_verification)

      user_from_signed_id = User.find_by_token_for!(:email_verification, signed_id)

      expect(user_from_signed_id).to eq(user)
    end

    it "Does not finds the user with a generated signed id after expiration" do
      user = create(:user)
      signed_id = user.generate_token_for(:email_verification)

      travel_to email_verification_expiration_time

      expect { User.find_by_token_for!(:email_verification, signed_id) }
        .to raise_error(ActiveSupport::MessageVerifier::InvalidSignature)
    end

    private

    def email_verification_expiration_time
      Avocado::UserTokens::EXPIRES_LONG.from_now + 2.minutes
    end
  end

  describe "Password reset" do
    it "Finds the user with a generated signed id" do
      user = create(:user)
      signed_id = user.generate_token_for(:password_reset)

      user_from_signed_id = User.find_by_token_for!(:password_reset, signed_id)

      expect(user_from_signed_id).to eq(user)
    end

    it "Does not finds the user with a generated signed id after expiration" do
      user = create(:user)
      signed_id = user.generate_token_for(:password_reset)

      travel_to password_reset_expiration_time

      expect { User.find_by_token_for!(:password_reset, signed_id) }
        .to raise_error(ActiveSupport::MessageVerifier::InvalidSignature)
    end

    private

    def password_reset_expiration_time
      Avocado::UserTokens::EXPIRES_LATER.from_now + 2.minutes
    end
  end
end

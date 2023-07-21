# frozen_string_literal: true

RSpec.describe "Verification" do
  describe "Requesting a verification email" do
    it "sends the email_verification email" do
      user = create(:user)
      sign_in user

      click_on "Re-send verification email"
      expect(page).to have_content(/Verification email sent/)
      expect(Avocado::Mailer.deliveries.size).to eq(1)
    end
  end

  describe "Verifying an email from a link" do
    context "with an expired link" do
      it "does not sign in the user" do
        user = create(:user)
        sign_in user
        user_signed_id = user.generate_token_for(:email_verification)

        travel_to (Avocado::UserTokens::EXPIRES_LONG + 1.day).from_now
        visit edit_verification_path(id: user_signed_id)

        expect(page).to have_content(/link is invalid/)
      end
    end

    it "verifies the user email when they click in time" do
      user = create(:user)
      sign_in user
      user_signed_id = user.generate_token_for(:email_verification)

      visit edit_verification_path(id: user_signed_id)
      click_on "Submit"

      expect(page).to have_content(/Email address verified/)
    end

    it "does not verify the user email when they wait too long" do
      user = create(:user)
      sign_in user
      user_signed_id = user.generate_token_for(:email_verification)

      visit edit_verification_path(id: user_signed_id)
      travel_to (Avocado::UserTokens::EXPIRES_LONG + 1.day).from_now
      click_on "Submit"

      expect(page).to have_content(/link is invalid/)
    end

    it "fails with bad link" do
      user = create(:user)
      sign_in user

      visit edit_verification_path(id: "fake")

      expect(page).to have_content(/link is invalid/)
    end
  end
end

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
    it "verifies the user email" do
      user = create(:user)
      sign_in user
      user_signed_id = user.generate_token_for(:email_verification)

      visit verification_path(id: user_signed_id)

      expect(page).to have_content(/Email address verified/)
    end

    it "fails with bad link" do
      user = create(:user)
      sign_in user

      visit verification_path(id: "fake")

      expect(page).to have_content(/link is invalid/)
    end
  end
end

RSpec.describe "Recoveries" do
  describe "Sending a password reset email" do
    it "sends the reset email" do
      user = create(:user, verified: true)

      visit new_recovery_path
      fill_in "Email", with: user.email
      click_on "Submit"

      expect(page).to have_content(/Check email for reset/)
      expect(Avocado::Mailer.deliveries.size).to eq(1)
    end

    it "does not send for a non-verified user" do
      user = create(:user, verified: true)
      user.update!(verified: false)

      visit new_recovery_path
      fill_in "Email", with: user.email
      click_on "Submit"

      expect(page).to have_content(/Verify email first/)
      expect(Avocado::Mailer.deliveries.size).to eq(0)
    end
  end

  describe "Changing a user password" do
    it "updates the password" do
      user = create(:user, verified: true)
      user_signed_id = user.generate_token_for(:password_reset)

      visit edit_credential_path(id: user_signed_id)
      fill_in "Password", with: "Password.New.123"
      fill_in "Password confirmation", with: "Password.New.123"
      click_on "Submit"

      expect(page).to have_content(/reset successfully/)
    end

    it "fails with non matching password" do
      user = create(:user, verified: true)
      user_signed_id = user.generate_token_for(:password_reset)

      visit edit_credential_path(id: user_signed_id)
      fill_in "Password", with: "Password.New.123"
      fill_in "Password confirmation", with: "Password.Wrong"
      click_on "Submit"

      expect(page).to have_content(/Change your password/)
    end

    it "fails with bad link" do
      visit edit_credential_path(id: "fake")

      expect(page).to have_content(/link is invalid/)
    end
  end
end

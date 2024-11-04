RSpec.describe "Recoveries" do
  describe "Sending a password reset email" do
    it "sends the reset email" do
      user = create(:user, verified: true)

      visit new_password_path
      find("#email_address").fill_in with: user.email_address
      within("form") { find("[type=submit]").click }

      expect(page).to have_content(/instructions sent/)
      expect(Avocado::Mailer.deliveries.size).to eq(1)
    end
  end

  describe "Changing a user password" do
    it "updates the password" do
      user = create(:user, verified: true)
      user_signed_id = user.password_reset_token

      visit edit_password_path(user_signed_id)
      find("#password").fill_in with: "Password.New.123"
      find("#password_confirmation").fill_in with: "Password.New.123"
      within("form") { find("[type=submit]").click }

      expect(page).to have_content(/has been reset/)
    end

    it "fails with non matching password" do
      user = create(:user, verified: true)
      user_signed_id = user.password_reset_token

      visit edit_password_path(user_signed_id)
      find("#password").fill_in with: "Password.New.123"
      find("#password_confirmation").fill_in with: "Password.Wrong"
      within("form") { find("[type=submit]").click }

      expect(page).to have_content(/did not match/)
    end

    it "fails with bad link" do
      visit edit_password_path("fake")

      expect(page).to have_content(/link is invalid/)
    end
  end
end

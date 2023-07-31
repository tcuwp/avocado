RSpec.describe "Emails" do
  describe "Changing a user email" do
    it "updates the email with correct current password" do
      user = create(:user)
      sign_in(user)

      visit edit_email_path

      fill_in "Email", with: "new@example.com"
      fill_in "Current password", with: "Password.12345"

      expect {
        click_on "Submit"
      }.to change(Avocado::Mailer.deliveries, :size).by(1)
      expect(page).to have_content(/has been changed/)
    end

    it "preserves current email with correct current password" do
      user = create(:user)
      sign_in(user)

      visit edit_email_path
      fill_in "Email", with: user.email
      fill_in "Current password", with: "Password.12345"

      expect {
        click_on "Submit"
      }.not_to change(Avocado::Mailer.deliveries, :size)
      expect(page).not_to have_content(/has been changed/)
    end

    it "does not update the email with incorrect password" do
      user = create(:user)
      sign_in(user)

      visit edit_email_path
      fill_in "Email", with: "new@example.com"
      fill_in "Current password", with: "Password.Wrong"
      click_on "Submit"

      expect(page).to have_content(/challenge failed/)
    end

    it "does not update the email with invalid value" do
      user = create(:user)
      sign_in(user)

      visit edit_email_path
      fill_in "Email", with: "new-at-domain-dot-com"
      fill_in "Current password", with: "Password.12345"
      click_on "Submit"

      expect(page).to have_content(/Change your email/)
    end
  end
end

# frozen_string_literal: true

RSpec.describe "Recoveries" do
  before do
    driven_by(:rack_test)
  end

  describe "Sending a password reset email" do
    it "sends the reset email" do
      user = create(:user, verified: true)

      visit new_recovery_path
      fill_in "Email", with: user.email
      click_on "Recover"

      expect(page).to have_content(/Check your email/)
    end

    it "does not send for a non-verified user" do
      user = create(:user, verified: true)
      user.update(verified: false)

      visit new_recovery_path
      fill_in "Email", with: user.email
      click_on "Recover"

      expect(page).to have_content(/Verify email first/)
    end
  end

  describe "Changing a user password" do
    it "updates the password" do
      user = create(:user, verified: true)
      user_sid = user.generate_token_for(:password_reset)

      visit edit_recovery_path(sid: user_sid)
      fill_in "Password", with: "Password.New.123"
      fill_in "Password confirmation", with: "Password.New.123"
      click_on "Update password"

      expect(page).to have_content(/reset successfully/)
    end

    it "fails with non matching password" do
      user = create(:user, verified: true)
      user_sid = user.generate_token_for(:password_reset)

      visit edit_recovery_path(sid: user_sid)
      fill_in "Password", with: "Password.New.123"
      fill_in "Password confirmation", with: "Password.Wrong"
      click_on "Update password"

      expect(page).to have_content(/Reset your password/)
    end

    it "fails with bad link" do
      visit edit_recovery_path(sid: "fake")

      expect(page).to have_content(/link is invalid/)
    end
  end
end

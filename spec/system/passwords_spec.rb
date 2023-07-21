# frozen_string_literal: true

RSpec.describe "Passwords" do
  describe "Changing the password" do
    it "updates password with valid inputs" do
      sign_in create(:user)
      visit edit_password_path

      fill_in "Current password", with: "Password.12345"
      fill_in "Password", with: "Password.23456"
      fill_in "Password confirmation", with: "Password.23456"
      click_on "Submit"

      expect(page).to have_content(/has been changed/)
    end

    it "does not updates password with wrong current password" do
      sign_in create(:user)
      visit edit_password_path

      fill_in "Current password", with: "Password.Wrong.Current"
      fill_in "Password", with: "Password.23456"
      fill_in "Password confirmation", with: "Password.23456"
      click_on "Submit"

      expect(page).to have_content(/challenge failed/)
    end

    it "does not updates password without matching confirmation" do
      sign_in create(:user)
      visit edit_password_path

      fill_in "Current password", with: "Password.12345"
      fill_in "Password", with: "Password.23456"
      fill_in "Password confirmation", with: "Password.Wrong"
      click_on "Submit"

      expect(page).to have_content(/Change your password/)
    end
  end
end

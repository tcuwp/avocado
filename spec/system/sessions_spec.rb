# frozen_string_literal: true

RSpec.describe "Sessions" do
  before do
    driven_by(:rack_test)
  end

  describe "Sign in page" do
    it "shows a sign in form" do
      visit new_session_path

      expect(page).to have_content(/Sign in/)
    end
  end

  describe "Signing in" do
    it "signs in with valid attributes" do
      user = create(:user)

      visit new_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on "Sign in"

      expect(page).to have_content(/successfully/)
    end

    it "fails with invalid attributes" do
      user = create(:user)

      visit new_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: "Wrong"
      click_on "Sign in"

      expect(page).to have_content(/incorrect/)
    end
  end
end

RSpec.describe "Sessions" do
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
      find("#email_address").fill_in with: user.email_address
      find("#password").fill_in with: user.password
      within("form") { click_on "Sign in" }

      expect(page).to have_content(/Signed in/)
    end

    it "fails with invalid attributes" do
      user = create(:user)

      visit new_session_path
      find("#email_address").fill_in with: user.email_address
      find("#password").fill_in with: "Wrong"
      within("form") { click_on "Sign in" }

      expect(page).to have_content(/Signed out/)
    end
  end

  context "when signed in" do
    before do
      sign_in create(:user)
    end

    describe "Active user sessions" do
      it "lists active user sessions" do
        visit sessions_path

        expect(page).to have_content(/Sessions/)
      end

      it "destroys an active session" do
        visit sessions_path
        click_on "Delete"

        expect(page).to have_content(/Signed out/)
      end
    end
  end
end

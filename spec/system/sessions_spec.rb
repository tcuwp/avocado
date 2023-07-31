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
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on "Submit"

      expect(page).to have_content(/Session created/)
    end

    it "fails with invalid attributes" do
      user = create(:user)

      visit new_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: "Wrong"
      click_on "Submit"

      expect(page).to have_content(/Authentication failed/)
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

        expect(page).to have_content(/Session destroyed/)
      end
    end
  end
end

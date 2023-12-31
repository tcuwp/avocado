RSpec.describe "Registration" do
  describe "Registration page" do
    it "shows a sign up form" do
      visit new_registration_path

      expect(page).to have_content(/Sign up/)
    end
  end

  describe "Registering" do
    it "creates a user with valid attributes" do
      visit new_registration_path

      fill_in "Email", with: "new@example.com"
      fill_in "Password", with: "Password.12345"
      fill_in "Password confirmation", with: "Password.12345"
      click_on "Submit"

      expect(page).to have_content(/successful/)
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end

    it "does not create a user with invalid attributes" do
      visit new_registration_path

      fill_in "Email", with: "new@example.com"
      fill_in "Password", with: "Password.12345"
      fill_in "Password confirmation", with: "Password.Wrong"
      click_on "Submit"

      expect(page).not_to have_content(/successful/)
      expect(ActionMailer::Base.deliveries.size).to eq(0)
    end
  end
end

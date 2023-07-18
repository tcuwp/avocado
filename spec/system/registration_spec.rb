RSpec.describe "Registration" do
  before do
    driven_by(:rack_test)
  end

  describe "Signing up" do
    it "shows a sign up form" do
      visit new_registration_path

      expect(page).to have_content(/Sign up/)
    end
  end
end

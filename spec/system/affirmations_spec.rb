RSpec.describe "Affirmations" do
  describe "sending a one-time email link" do
    context "with a verified user" do
      it "sends a link" do
        user = create(:user, verified: true)
        visit new_affirmation_path

        fill_in "Email address", with: user.email_address
        click_on "Submit"

        expect(page).to have_content(/Check email for/)
      end
    end

    context "with a non verified user" do
      it "sends a link" do
        user = create(:user, verified: false)
        visit new_affirmation_path
        fill_in "Email address", with: user.email_address
        click_on "Submit"

        expect(page).to have_content(/Verify email first/)
      end
    end
  end

  describe "using the email link" do
    context "with an expired link" do
      it "does not sign in the user" do
        user = create(:user, verified: false)
        user_sid = user.generate_token_for(:email_verification)

        travel_to (Avocado::UserTokens::EXPIRES_FAST + 1.day).from_now

        visit edit_affirmation_path(id: user_sid)

        expect(page).to have_content(/is invalid/)
      end
    end

    context "with a valid link" do
      it "signs in the user when they click in time" do
        user = create(:user, verified: false)
        user_sid = user.generate_token_for(:email_affirmation)

        visit edit_affirmation_path(id: user_sid)
        click_on "Submit"

        expect(page).to have_content(/Signed in/)
      end

      it "does not sign in the user with a long delay" do
        user = create(:user, verified: false)
        user_sid = user.generate_token_for(:email_affirmation)

        visit edit_affirmation_path(id: user_sid)
        travel_to (Avocado::UserTokens::EXPIRES_FAST + 1.day).from_now
        click_on "Submit"

        expect(page).to have_content(/is invalid/)
      end
    end
  end
end

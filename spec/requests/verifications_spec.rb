RSpec.describe "Verifications" do
  describe "Requesting a verification email while signed out" do
    it "sends the email_verification email" do
      post verifications_path

      expect(response).to redirect_to(new_session_path)
    end
  end
end

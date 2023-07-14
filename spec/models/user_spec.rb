# frozen_string_literal: true

RSpec.describe User do
  describe "Authentication" do
    it "Authenticates by email and password" do
      user_params = {email: "test@host.example", password: "Test.1234"}
      user = create(:user, user_params)

      expect(described_class.authenticate_by(user_params)).to eq(user)
    end
  end
end

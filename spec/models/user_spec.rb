# frozen_string_literal: true

RSpec.describe User do
  describe "Authentication" do
    it "Authenticates by email and password" do
      user_params = {email: "test@host.example", password: "Test.1234"}
      user = create(:user, user_params)

      expect(described_class.authenticate_by(user_params)).to eq(user)
    end
  end

  describe "Scopes" do
    describe ".verified" do
      it "returns only verified users" do
        verified_user = create(:user, verified: true)
        un_verified_user = create(:user, verified: false)

        expect(described_class.verified).to eq [verified_user]
      end
    end
  end
end

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

    describe ".newest_first" do
      it "orders records by created_at desc" do
        newer = create(:user, created_at: 1.days.ago)
        older = create(:user, created_at: 3.days.ago)

        expect(described_class.newest_first).to eq [newer, older]
      end
    end
  end
end

# frozen_string_literal: true

RSpec.describe User do
  describe "Authentication" do
    it "authenticates with email and password" do
      user_params = {email: "test@host.example", password: "test"}
      user = create(:user, user_params)

      expect(described_class.authenticate_by(user_params)).to eq(user)
    end
  end

  describe "Validations" do
    subject { create(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end
end

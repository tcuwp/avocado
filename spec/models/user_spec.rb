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
    describe "Email presence" do
      it { is_expected.to validate_presence_of(:email) }
    end

    describe "Email uniqueness" do
      subject { create(:user) }

      it { is_expected.to validate_uniqueness_of(:email) }
    end

    describe "Email format" do
      it { is_expected.not_to allow_value("host.example").for(:email) }
      it { is_expected.not_to allow_value("user@").for(:email) }
      it { is_expected.not_to allow_value("user@host.example@host.example").for(:email) }
      it { is_expected.to allow_value("user@host.example").for(:email) }
    end
  end
end

# frozen_string_literal: true

RSpec.describe User do
  describe "Authentication" do
    it "authenticates with email and password" do
      user_params = {email: "test@host.example", password: "Test.1234"}
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

      it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end

    describe "Email format" do
      it { is_expected.not_to allow_value("host.example").for(:email) }
      it { is_expected.not_to allow_value("user@").for(:email) }
      it { is_expected.not_to allow_value("user@host.example@host.example").for(:email) }
      it { is_expected.to allow_value("user@host.example").for(:email) }
      it { is_expected.to allow_value("user@multiple.names.host.example").for(:email) }
      it { is_expected.to allow_value("user+scope@host.example").for(:email) }
    end

    describe "Password" do
      it { is_expected.not_to allow_value("!@#$%^&*").for(:password) }
      it { is_expected.not_to allow_value("12341234").for(:password) }
      it { is_expected.not_to allow_value("TestTest").for(:password) }
      it { is_expected.to allow_value("Test.1234").for(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(Avocado::UserPasswordConcern::REQUIRED_LENGTH) }
      it { is_expected.to validate_presence_of(:password) }
    end
  end

  describe "Normalizations" do
    describe "Email" do
      it "removes whitespace during save" do
        user = create(:user, email: "  user@host.example   ")

        expect(user.email).to eq("user@host.example")
      end

      it "downcases during save" do
        user = create(:user, email: "User@HOSt.exAMPle")

        expect(user.email).to eq("user@host.example")
      end
    end
  end
end

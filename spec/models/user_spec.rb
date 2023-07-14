# frozen_string_literal: true

RSpec.describe User do
  describe "Authentication" do
    it "authenticates with email and password" do
      user_params = {email: "test@host.example", password: "test"}
      user = described_class.new(user_params)
      user.save

      expect(described_class.authenticate_by(user_params)).to eq(user)
    end
  end

  describe "Validations" do
    subject { described_class.create(email: "test@host.example", password: "test") }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end
end

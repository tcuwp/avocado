# frozen_string_literal: true

RSpec.describe Avocado::UserEmailConcern, type: :model do
  subject { User.new }

  describe "Validations" do
    describe "Presence" do
      it { is_expected.to validate_presence_of(:email) }
    end

    describe "Uniqueness" do
      subject { create(:user) }

      it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end

    describe "Format" do
      it { is_expected.not_to allow_value("host.example").for(:email) }
      it { is_expected.not_to allow_value("user@").for(:email) }
      it { is_expected.not_to allow_value("user@host.example@host.example").for(:email) }
      it { is_expected.to allow_value("user@host.example").for(:email) }
      it { is_expected.to allow_value("user@multiple.names.host.example").for(:email) }
      it { is_expected.to allow_value("user+scope@host.example").for(:email) }
    end
  end

  describe "Normalizations" do
    describe "Whitespace" do
      it "Strips value during save" do
        user = create(:user, email: "  user@host.example   ")

        expect(user.email).to eq("user@host.example")
      end
    end

    describe "Mixed casing" do
      it "Downcases during save" do
        user = create(:user, email: "User@HOSt.exAMPle")

        expect(user.email).to eq("user@host.example")
      end
    end
  end
end

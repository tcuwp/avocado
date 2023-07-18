require "spec_helper"

RSpec.describe Avocado::Mailer do
  describe "Password reset" do
    it "creates an email" do
      user = create(:user)
      mail = described_class.with(user: user).password_reset

      expect(mail.subject).to match(/Password reset/)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["no-reply@host.example"])
      expect(mail.body.encoded).to match(/Password reset email/)
    end
  end

  describe "Email verification" do
    it "creates an email" do
      user = create(:user)
      mail = described_class.with(user: user).email_verification

      expect(mail.subject).to match(/Email verification/)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["no-reply@host.example"])
      expect(mail.body.encoded).to match(/Email verification email/)
    end
  end

  describe "Email affirmation" do
    it "creates an email" do
      user = create(:user)
      mail = described_class.with(user: user).email_affirmation

      expect(mail.subject).to match(/Email affirmation/)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["no-reply@host.example"])
      expect(mail.body.encoded).to match(/Email affirmation email/)
    end
  end
end

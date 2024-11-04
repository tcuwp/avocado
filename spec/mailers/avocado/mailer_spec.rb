RSpec.describe Avocado::Mailer do
  describe "Email verification" do
    it "creates an email" do
      user = create(:user)
      mail = described_class.with(user: user).email_verification

      expect(mail.subject).to match(/Email verification/)
      expect(mail.to).to eq([user.email_address])
      expect(mail.from).to eq(["no-reply@host.example"])
      expect(mail.body.encoded).to match(/Verify your email/)
    end
  end

  describe "Email affirmation" do
    it "creates an email" do
      user = create(:user)
      mail = described_class.with(user: user).email_affirmation

      expect(mail.subject).to match(/Email affirmation/)
      expect(mail.to).to eq([user.email_address])
      expect(mail.from).to eq(["no-reply@host.example"])
      expect(mail.body.encoded).to match(/Sign in by following/)
    end
  end
end

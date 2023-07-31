RSpec.describe User do
  describe "Authentication" do
    it "Authenticates by email and password" do
      user_params = {email: "test@host.example", password: "Test.1234"}
      user = create(:user, user_params)

      expect(described_class.authenticate_by(user_params)).to eq(user)
    end
  end

  describe "Associations" do
    it { is_expected.to have_many(:events).dependent(:destroy) }
    it { is_expected.to have_many(:sessions).dependent(:destroy) }
  end

  describe "Scopes" do
    describe ".verified" do
      it "returns only verified users" do
        verified_user = create(:user, verified: true)
        _unverified_user = create(:user, verified: false)

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

  describe "Validations" do
    describe "Password" do
      it { is_expected.not_to allow_value("!@#$%^&*").for(:password) }
      it { is_expected.not_to allow_value("12341234").for(:password) }
      it { is_expected.not_to allow_value("TestTest").for(:password) }
      it { is_expected.to allow_value("Test.1234").for(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(Avocado::UserValidations::PASSWORD_MINIMUM_LENGTH) }
      it { is_expected.to validate_presence_of(:password) }
    end

    describe "Email" do
      subject { create(:user) }

      it { is_expected.not_to allow_value("host.example").for(:email) }
      it { is_expected.not_to allow_value("user@").for(:email) }
      it { is_expected.not_to allow_value("user@host.example@host.example").for(:email) }
      it { is_expected.to allow_value("user@host.example").for(:email) }
      it { is_expected.to allow_value("user@multiple.names.host.example").for(:email) }
      it { is_expected.to allow_value("user+scope@host.example").for(:email) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end
  end

  describe "Callbacks" do
    describe "Password changes" do
      it "logs action in a user event" do
        user = create(:user)

        expect { user.update(password: "New.Pass.123", password_confirmation: "New.Pass.123") }.to change(user.events, :count).by(1)
        expect(user.events.last.action).to eq("password:update")
      end

      it "destroys non current sessions" do
        user = create(:user)
        desktop_session = create(:session, user: user)
        tablet_session = create(:session, user: user)
        phone_session = create(:session, user: user)

        Avocado::Current.session = phone_session

        expect { user.update(password: "New.Pass.123", password_confirmation: "New.Pass.123") }.to change(user.sessions, :count).from(3).to(1)
        expect { desktop_session.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect { tablet_session.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "Email changes" do
      it "sets verified to false when email changes" do
        user = create(:user, email: "user@host.example", verified: true)

        expect { user.update(email: "new@host.example") }.to change(user, :verified).from(true).to(false)
      end

      it "logs action in a user event" do
        user = create(:user, email: "user@host.example", verified: true)

        expect { user.update(email: "new@host.example") }.to change(user.events, :count).by(1)
        expect(user.events.last.action).to eq("email:update")
      end
    end

    describe "Verified changes" do
      it "logs action in a user event" do
        user = create(:user, verified: false)

        expect { user.update(verified: true) }.to change(user.events, :count).by(1)
        expect(user.events.last.action).to eq("email:verified")
      end
    end
  end
end

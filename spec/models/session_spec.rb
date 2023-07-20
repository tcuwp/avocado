# frozen_string_literal: true

RSpec.describe Session do
  describe "Scopes" do
    describe ".newest_first" do
      it "orders records by created_at desc" do
        newer = create(:session, created_at: 1.days.ago)
        older = create(:session, created_at: 3.days.ago)

        expect(described_class.newest_first).to eq [newer, older]
      end
    end
  end

  describe "Callbacks" do
    describe "Request logging" do
      after do
        Avocado::Current.reset_all
      end

      it "does not set values when not present" do
        session = create(:session)

        expect(session.user_agent).to be_nil
        expect(session.ip_address).to be_nil
      end

      it "sets values when present" do
        Avocado::Current.ip_address = "192.168.1.1"
        Avocado::Current.user_agent = "Mozilla 1.0"

        session = create(:session)
        expect(session.user_agent).to eq("Mozilla 1.0")
        expect(session.ip_address).to eq("192.168.1.1")
      end
    end

    describe "Session creation" do
      it "logs action in a user event" do
        user = create(:user)

        expect { create(:session, user: user) }.to change(user.events, :count).by(1)
        expect(user.events.last.action).to eq("session:create")
      end
    end

    describe "Session destruction" do
      it "logs action in a user event" do
        user = create(:user)
        session = create(:session, user: user)

        expect { session.destroy }.to change(user.events, :count).by(1)
        expect(user.events.last.action).to eq("session:destroy")
      end
    end
  end
end

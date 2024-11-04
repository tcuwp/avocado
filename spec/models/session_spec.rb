RSpec.describe Session do
  describe "Scopes" do
    describe ".newest_first" do
      it "orders records by created_at desc" do
        newer = create(:session, created_at: 1.days.ago)
        older = create(:session, created_at: 3.days.ago)

        expect(described_class.newest_first).to eq [newer, older]
      end
    end

    describe ".non_current" do
      after do
        Current.reset_all
      end

      it "finds non current records when current is set" do
        mobile_session = create(:session)
        tablet_session = create(:session)

        Current.session = mobile_session

        expect(described_class.non_current).to eq [tablet_session]
      end

      it "finds all records when current not set" do
        mobile_session = create(:session)
        tablet_session = create(:session)

        expect(described_class.non_current).to eq [mobile_session, tablet_session]
      end
    end
  end

  describe "Callbacks" do
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

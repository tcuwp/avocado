# frozen_string_literal: true

RSpec.describe Event do
  describe "Scopes" do
    describe ".newest_first" do
      it "orders records by created_at desc" do
        newer = create(:event, created_at: 1.days.ago)
        older = create(:event, created_at: 3.days.ago)

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
        event = create(:event)

        expect(event.user_agent).to be_nil
        expect(event.ip_address).to be_nil
      end

      it "sets values when present" do
        Avocado::Current.ip_address = "192.168.1.1"
        Avocado::Current.user_agent = "Mozilla 1.0"

        event = create(:event)
        expect(event.user_agent).to eq("Mozilla 1.0")
        expect(event.ip_address).to eq("192.168.1.1")
      end
    end
  end

  describe "Validations" do
    describe "Action" do
      it { is_expected.to validate_inclusion_of(:action).in_array(Avocado::Event::VALID_ACTIONS) }
    end
  end
end

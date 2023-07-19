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
end

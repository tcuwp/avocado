# frozen_string_literal: true

RSpec.describe "Events" do
  describe "When signed in" do
    before do
      sign_in create(:user)
    end

    describe "Viewing events list" do
      it "views all user events" do
        visit events_path

        expect(page).to have_content("session:create")
      end
    end
  end
end

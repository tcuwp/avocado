# frozen_string_literal: true

RSpec.describe User do
  it "authenticates with email and password" do
    user_params = {email: "test@host.example", password: "test"}
    user = User.new(user_params)
    user.save

    expect(described_class.authenticate_by(user_params)).to eq(user)
  end
end

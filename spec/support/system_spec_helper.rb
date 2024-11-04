module SystemSpecHelper
  def sign_in(user)
    visit new_session_path

    find("#email_address").fill_in with: user.email_address
    find("#password").fill_in with: user.password
    click_button "Sign in"
  end
end

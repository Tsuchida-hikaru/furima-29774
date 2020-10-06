module SignInSupport
  def sign_in(user)
    visit root_path
    click_on('ログイン')
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_on('ログイン')
  end
end

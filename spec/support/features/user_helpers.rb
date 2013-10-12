module Features
  module UserHelpers

    def log_in_with(email, password)
      within("nav") do
        fill_in 'Email', with: email
        fill_in 'password', with: password
        click_button 'Log in'
      end
    end

    def sign_up_with(email, password, password_confirmation)
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password_confirmation
      click_button 'Save User'
    end

  end

end

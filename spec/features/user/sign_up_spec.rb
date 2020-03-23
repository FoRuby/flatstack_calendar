require 'rails_helper'

feature 'User can sign up', %q{
  As User
  I'd like to be able to sign up
} do
  given(:user) { create :user }

  describe 'User tries to sign up' do
    background { visit new_user_registration_path }

    scenario 'with valid params' do
      fill_in 'Name', with: 'Foobar'
      fill_in 'Email', with: 'foobar@example.com'
      fill_in 'Password', with: 'foobar'
      fill_in 'Password confirmation', with: 'foobar'
      within('.actions') { click_on 'Sign up' }

      open_email 'foobar@example.com'
      current_email.click_link 'Confirm my account'

      expect(page)
        .to have_content 'Your email address has been successfully confirmed.'
    end

    scenario 'with invalid password length' do
      fill_in 'Name', with: 'Foobar'
      fill_in 'Email', with: 'testemail@example.com'
      fill_in 'Password', with: '5char'
      fill_in 'Password confirmation', with: '5char'
      within('.actions') { click_on 'Sign up' }

      expect(page)
        .to have_content 'Password is too short (minimum is 6 characters)'
    end

    scenario 'with different values
      in the fields Password and Password confirmation' do
      fill_in 'Name', with: 'Foobar'
      fill_in 'Email', with: 'testemail@example.com'
      fill_in 'Password', with: 'foobar'
      fill_in 'Password confirmation', with: 'foo'
      within('.actions') { click_on 'Sign up' }

      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    scenario 'with existing Email' do
      fill_in 'Name', with: 'Foobar'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'foobar'
      fill_in 'Password confirmation', with: 'foobar'
      within('.actions') { click_on 'Sign up' }

      expect(page).to have_content 'Email has already been taken'
    end
  end
end

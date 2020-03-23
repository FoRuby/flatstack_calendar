require 'rails_helper'

feature 'User can sign in', %q{
  As User
  I'd like to be able to sign in
} do

  background { visit new_user_session_path }

  describe 'Registered user' do
    given(:user) { create :user }

    scenario 'tries to sign in with correct params' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      within('.actions') { click_on 'Log in' }

      expect(page).to have_content 'Signed in successfully.'
    end

    scenario 'tries to sign in with incorrect params' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'foo'
      within('.actions') { click_on 'Log in' }

      expect(page).to have_content 'Invalid Email or password.'
    end

    scenario 'tries to sign in repeatedly' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      within('.actions') { click_on 'Log in' }

      visit new_user_session_path

      expect(page).to have_content 'You are already signed in.'
    end
  end

  scenario 'Unregistered user tries to sign in' do
    fill_in 'Email', with: 'newuser@example.com'
    fill_in 'Password', with: 'foobar'
    within('.actions') { click_on 'Log in' }

    expect(page).to have_content 'Invalid Email or password.'
  end
end

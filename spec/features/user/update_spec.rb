require 'rails_helper'

feature 'User can edit his profile', %q{
  As User
  I'd like to be able to edit my profile
} do
  given(:user) { create :user }
  given(:exist_user) { create :user }

  describe 'User tries to edit his profile' do
    background do
      login user
      click_on user.name
      click_on 'Edit profile'
    end

    context 'name' do
      scenario 'change name with valid params' do
        fill_in 'Name', with: 'Foobar'
        fill_in 'Current password', with: user.password
        click_on 'Update'

        expect(page)
          .to have_content 'Your account has been updated successfully.'
      end

      scenario 'change name with invalid params' do
        fill_in 'Name', with: ''
        fill_in 'Current password', with: user.password
        click_on 'Update'

        expect(page).to have_content "Name can't be blank"
      end
    end

    context 'email' do
      scenario 'change email with valid params' do
        fill_in 'Email', with: 'foobar@example.com'
        fill_in 'Current password', with: user.password
        click_on 'Update'

        open_email 'foobar@example.com'
        current_email.click_link 'Confirm my account'

        expect(page)
          .to have_content 'Your email address has been successfully confirmed.'
      end

      scenario 'change email with invalid params' do
        fill_in 'Email', with: exist_user.email
        fill_in 'Current password', with: user.password
        click_on 'Update'

        expect(page).to have_content 'Email has already been taken'
      end
    end

    context 'password' do
      scenario 'change password with valid params' do
        fill_in 'New password', with: 'foobar'
        fill_in 'Password confirmation', with: 'foobar'
        fill_in 'Current password', with: user.password
        click_on 'Update'

        expect(page)
          .to have_content 'Your account has been updated successfully.'
      end

      scenario 'change password with invalid params' do
        fill_in 'New password', with: 'foo'
        fill_in 'Password confirmation', with: 'bar'
        fill_in 'Current password', with: user.password
        click_on 'Update'

        expect(page)
          .to have_content "Password confirmation doesn't match Password"
        expect(page)
          .to have_content 'Password is too short (minimum is 6 characters)'
      end
    end
  end
end

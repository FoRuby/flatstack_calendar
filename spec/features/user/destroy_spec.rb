require 'rails_helper'

feature 'User can delete his profile', %q{
  As User
  I'd like to be able to delete my profile
} do
  given(:user) { create :user }
  given(:exist_user) { create :user }

  describe 'User tries to delete his profile' do
    background do
      login user
      click_on user.name
      click_on 'Edit profile'
    end

    scenario 'destroy' do
      click_on 'Delete my account'

      expect(page)
        .to have_content 'Bye! Your account has been successfully cancelled. '\
                         'We hope to see you again soon.'
    end
  end
end

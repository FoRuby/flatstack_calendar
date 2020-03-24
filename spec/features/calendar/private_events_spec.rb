require 'rails_helper'

feature 'User can create private events', %(
  As authenticated User
  I'd like to create private event
) do
  describe 'Authenticated user', js: true do
    given(:user) { create :user }
    given!(:public_simple_event) do
      create :simple_event, duration: 1
    end
    given!(:private_simple_event) do
      create :simple_event, duration: 1, visibility: 'private', user: user
    end

    background do
      login(user)
      visit calendar_path
    end

    scenario "sees his private event on 'My Events' tab" do
      click_on 'My Events'

      expect(page).to have_content private_simple_event.title
    end

    scenario "does nor sees his private event on 'Public Events' tab" do
      click_on 'Public Events'

      expect(page).to_not have_content private_simple_event.title
    end
  end
end

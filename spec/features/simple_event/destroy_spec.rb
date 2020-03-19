require 'rails_helper'

feature 'User can destroy simple event', %(
  As authenticated event author
  I'd like to destroy event
) do

  describe 'Authenticated user', js: true do
    given!(:simple_event) { create :simple_event, date: Date.current, duration: 1 }

    background do
      # login(user)
      visit root_path
      find("#event-#{simple_event.id}").click
    end

    scenario 'tries to update simple event with correct params' do
      within('#calendar') do
        expect(page).to have_content simple_event.title.to_s
      end

      accept_confirm { click_on 'Delete event' }

      expect(page).to have_content 'Event was succesfully destroyed!'
      within('#calendar') do
        expect(page).to_not have_content simple_event.title.to_s
      end
    end
  end
end

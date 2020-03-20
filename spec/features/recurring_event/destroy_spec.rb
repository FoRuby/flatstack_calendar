require 'rails_helper'

feature 'User can destroy recurring event', %(
  As authenticated event author
  I'd like to destroy event
) do
  describe 'Authenticated user', js: true do
    given!(:recurring_event) do
      create :recurring_event, :daily, start_date: Date.today,
                                       end_date: Date.today + 2
    end

    background do
      # login(user)
      visit root_path
      first("#event-#{recurring_event.id}").click
    end

    scenario 'tries to destroy recurring event' do
      within('#calendar') do
        expect(page).to have_content recurring_event.title.to_s,
                                     count: recurring_event.dates.count
      end

      accept_confirm { click_on 'Delete event' }

      expect(page).to have_content 'Event was succesfully destroyed!'
      within('#calendar') do
        expect(page).to_not have_content recurring_event.title.to_s
      end
    end
  end
end

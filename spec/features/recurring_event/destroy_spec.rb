require 'rails_helper'

feature 'User can destroy recurring event', %(
  As authenticated event author
  I'd like to destroy event
) do
  describe 'Authenticated user', js: true do
    given(:author) { create :user }
    given!(:recurring_event) do
      create :recurring_event, :daily, user: author,
                                       start_date: Date.today,
                                       end_date: Date.today + 1
    end

    context 'author' do
      background do
        login author
        visit calendar_path
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

    context 'not author' do
      given(:user) { create :user }

      background do
        login user
        visit calendar_path
        first("#event-#{recurring_event.id}").click
      end

      scenario 'tries to destroy recurring event' do
        expect(page).to_not have_content 'Delete event'
      end
    end
  end

  describe 'Unauthenticated user', js: true do
    scenario 'tries to destroy recurring event' do
      visit calendar_path

      expect(page)
        .to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end

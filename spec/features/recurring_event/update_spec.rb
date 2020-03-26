require 'rails_helper'

feature 'User can update recurring event', %(
  As authenticated event author
  I'd like to update event
) do
  describe 'Authenticated user', js: true do
    given(:author) { create :user }
    given!(:recurring_event) do
      create :recurring_event, :daily, user: author,
                                       start_date: Date.today,
                                       end_date: Date.today + 2
    end

    context 'author' do
      background do
        login author
        visit calendar_path
        first("#event-#{recurring_event.id}").click
        click_on 'Edit event'
      end

      scenario 'tries to update recurring event with correct params' do
        within('.show-event-modal') do
          fill_in 'Title', with: 'TestTitle'
          fill_in 'Description', with: 'TestDescription'
          select 'public', from: 'Visibility'
          fill_in 'Color', with: '#2c1c93'
          fill_in 'Start date', with: Date.today.to_s
          fill_in 'End date', with: Date.tomorrow.to_s

          click_on 'Update Recurring event'
        end

        expect(page).to have_content 'Event was succesfully updated!'
        expect(page).to have_content 'TestTitle', count: 2

        color = first("#event-#{recurring_event.id}")
                .style('background-color')['background-color']
        expect(color.paint.to_hex).to eq '#2c1c93'

        first("#event-#{recurring_event.id}").click
        within('.show-event-modal') do
          expect(page).to have_content 'TestTitle'
          expect(page).to have_content 'TestDescription'
        end
      end

      scenario 'tries to update recurring event with invalid dates' do
        within('.show-event-modal') do
          fill_in 'Title', with: 'TestTitle'
          fill_in 'Description', with: 'TestDescription'
          select 'public', from: 'Visibility'
          fill_in 'Color', with: '#2c1c93'
          fill_in 'Start date', with: Date.tomorrow.to_s
          fill_in 'End date', with: Date.today.to_s

          click_on 'Update Recurring event'

          expect(page).to have_content 'Start date should be less then end date'
          expect(page).to have_content 'End date should be greater then start date'
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

      scenario 'tries to update recurring event' do
        expect(page).to_not have_content 'Edit event'
      end
    end
  end

  describe 'Unauthenticated user', js: true do
    scenario 'tries to update recurring event' do
      visit calendar_path

      expect(page)
        .to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end

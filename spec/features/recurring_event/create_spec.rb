require 'rails_helper'

feature 'User can create recurring event', %(
  As authenticated User
  I'd like to create recurring event
) do
  describe 'Authenticated user', js: true do
    given(:user) { create :user }

    background do
      login(user)
      visit calendar_path
    end

    scenario 'tries to create recurring event with correct params' do
      find(:css, '.fc-day.fc-today').click
      click_on 'Recurring Event'

      within('.new-event-modal') do
        fill_in 'Title', with: 'TestTitle'
        fill_in 'Description', with: 'TestDescription'
        select 'public', from: 'Visibility'
        fill_in 'Color', with: '#2c1c93'
        fill_in 'Start date', with: Date.today.to_s
        fill_in 'End date', with: Date.tomorrow.to_s

        click_on 'Create Recurring event'
      end

      expect(page).to have_content 'Event was succesfully created!'
      expect(page).to have_content 'TestTitle', count: 2

      color = first("#event-#{Event.last.id}")
              .style('background-color')['background-color']
      expect(color.paint.to_hex).to eq '#2c1c93'
    end

    scenario 'tries to create recurring event with invalid dates' do
      find(:css, '.fc-day.fc-today').click
      click_on 'Recurring Event'

      within('.new-event-modal') do
        fill_in 'Title', with: 'TestTitle'
        fill_in 'Description', with: 'TestDescription'
        select 'public', from: 'Visibility'
        fill_in 'Color', with: '#2c1c93'
        fill_in 'Start date', with: Date.tomorrow.to_s
        fill_in 'End date', with: Date.today.to_s

        click_on 'Create Recurring event'
      end

      expect(page).to have_content 'Start date should be less then end date'
      expect(page).to have_content 'End date should be greater then start date'
    end
  end

  describe 'Unauthenticated user', js: true do
    scenario 'tries to create recurring event' do
      visit calendar_path

      expect(page)
        .to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end

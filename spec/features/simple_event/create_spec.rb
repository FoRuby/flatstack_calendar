require 'rails_helper'

feature 'User can create simple event', %(
  As authenticated User
  I'd like to create simple event
) do
  describe 'Authenticated user', js: true do
    given(:user) { create :user }

    background do
      login(user)
      visit calendar_path
    end

    scenario 'tries to create simple event with correct params' do
      find(:css, '.fc-day.fc-today').click

      within('.new-event-modal') do
        fill_in 'Title', with: 'TestTitle'
        fill_in 'Description', with: 'TestDescription'
        fill_in 'Date', with: Date.today.to_s
        fill_in 'Duration', with: 1
        fill_in 'Color', with: '#2c1c93'
        select 'public', from: 'Visibility'

        click_on 'Create Simple event'
      end

      expect(page).to have_content 'Event was succesfully created!'
      expect(page).to have_content 'TestTitle'

      color = find("#event-#{Event.last.id}")
              .style('background-color')['background-color']
      expect(color.paint.to_hex).to eq '#2c1c93'
    end

    # Error window still work, but replaced html form validation
    # scenario 'tries to create simple event with invalid params' do
    #   find(:css, '.fc-day.fc-today').click
    #
    #   within('.new-event-modal') do
    #     fill_in 'Title', with: ''
    #     fill_in 'Date', with: ''
    #     fill_in 'Duration', with: '0'
    #
    #     click_on 'Create Simple event'
    #
    #     expect(page).to have_content "Title can't be blank"
    #     expect(page).to have_content "Date can't be blank"
    #     expect(page).to have_content 'Duration must be greater than 0'
    #   end
    # end
  end

  describe 'Unauthenticated user', js: true do
    scenario 'tries to create simple event' do
      visit calendar_path

      expect(page)
        .to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end

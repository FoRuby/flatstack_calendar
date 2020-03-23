require 'rails_helper'

feature 'User can update simple event', %(
  As authenticated event author
  I'd like to update event
) do
  describe 'Authenticated user', js: true do
    given!(:simple_event) do
      create :simple_event, date: Date.current, duration: 1
    end

    background do
      # login(user)
      visit calendar_path
      find("#event-#{simple_event.id}").click
      click_on 'Edit event'
    end

    scenario 'tries to update simple event with correct params' do
      within('.show-event-modal') do
        fill_in 'Title', with: 'TestTitle'
        fill_in 'Description', with: 'TestDescription'
        fill_in 'Date', with: Date.tomorrow
        fill_in 'Color', with: '#2c1c93'
        select 'public', from: 'Visibility'

        click_on 'Update Simple event'
      end

      expect(page).to have_content 'Event was succesfully updated!'
      expect(page).to have_content 'TestTitle'

      color = find("#event-#{simple_event.id}")
              .style('background-color')['background-color']
      expect(color.paint.to_hex).to eq '#2c1c93'

      find("#event-#{simple_event.id}").click
      within('.show-event-modal') do
        expect(page).to have_content 'TestTitle'
        expect(page).to have_content 'TestDescription'
      end
    end
    # Error window still work, but replaced html form validation
    # scenario 'tries to update simple event with invalid params' do
    #   within('.show-event-modal') do
    #     fill_in 'Title', with: ''
    #     fill_in 'Description', with: ''
    #     fill_in 'Date', with: Date.new
    #     fill_in 'Duration', with: 0
    #     select 'public', from: 'Visibility'
    #
    #     click_on 'Update Simple event'
    #
    #     expect(page).to have_content "Title can't be blank"
    #     expect(page).to have_content "Date can't be blank"
    #     expect(page).to have_content 'Duration must be greater than 0'
    #   end
    # end
  end
end

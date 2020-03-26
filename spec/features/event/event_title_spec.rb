require 'rails_helper'

feature 'interactive changing event title', js: true do
  given!(:simple_event) do
    create :simple_event, date: Date.current, duration: 1
  end

  background do
    login simple_event.user
    visit calendar_path
    find("#event-#{simple_event.id}").click
    click_on 'Edit event'
  end

  scenario 'change header title', js: true do
    within('.show-event-modal') do
      expect(page).to have_field 'Title', with: simple_event.title.to_s
      expect(page).to have_css '.modal-header h1', text: simple_event.title.to_s

      fill_in 'Title', with: 'foobar'

      expect(page).to have_field 'Title', with: 'foobar'
      expect(page).to have_css '.modal-header h1', text: 'foobar'
    end
  end
end

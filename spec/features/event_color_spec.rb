require 'rails_helper'

feature 'interactive changing event header color', js: true do
  given!(:simple_event) do
    create :simple_event, date: Date.current, duration: 1
  end

  background do
    visit root_path
    find("#event-#{simple_event.id}").click
    click_on 'Edit event'
  end

  scenario 'change header color', js: true do
    within('.show-event-modal') do
      header_old_color = find('.modal-header')
                         .style('background-color')['background-color']
      expect(header_old_color.paint.to_hex).to eq simple_event.color

      fill_in 'Color', with: '#2c1c93'
      header_new_color = find('.modal-header')
                         .style('background-color')['background-color']
      expect(header_new_color.paint.to_hex).to eq '#2c1c93'
    end
  end
end

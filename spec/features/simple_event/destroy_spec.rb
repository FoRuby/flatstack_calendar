require 'rails_helper'

feature 'User can destroy simple event', %(
  As authenticated event author
  I'd like to destroy event
) do
  describe 'Authenticated', js: true do
    given(:author) { create :user }
    given!(:simple_event) do
      create :simple_event, user: author, date: Date.current, duration: 1
    end

    context 'author' do
      background do
        login author
        visit calendar_path
        find("#event-#{simple_event.id}").click
      end

      scenario 'tries to destroy simple event' do
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

    context 'not author' do
      given(:user) { create :user }

      background do
        login user
        visit calendar_path
        find("#event-#{simple_event.id}").click
      end

      scenario 'tries to destroy simple event' do
        expect(page).to_not have_content 'Delete event'
      end
    end
  end

  describe 'Unauthenticated user', js: true do
    scenario 'tries to destroy simple event' do
      visit calendar_path

      expect(page)
        .to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end

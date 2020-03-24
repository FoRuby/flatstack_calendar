require 'rails_helper'

RSpec.describe CalendarsController, type: :controller do
  describe 'GET #recurring_events' do
    let!(:recurring_events) do
      create_list :recurring_event, 2, :daily, visibility: 'public'
    end

    describe 'Authenticated user' do
      let(:user) { create :user }

      before do
        login user
        get :recurring_events, format: :json
      end

      it 'assign an array of public recurring_events' do
        expect(assigns(:recurring_events))
          .to match_array recurring_events.map(&:events).flatten
      end

      it 'respond with json format' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'returns status :ok' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'Unauthenticated user' do
      before { get :recurring_events, format: :json }

      it 'does not assign an array of public recurring_events' do
        expect(assigns(:recurring_events))
          .to_not match_array recurring_events.map(&:events).flatten
      end

      it 'returns status :unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end

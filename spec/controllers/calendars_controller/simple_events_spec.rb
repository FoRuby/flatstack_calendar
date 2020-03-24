require 'rails_helper'

RSpec.describe CalendarsController, type: :controller do
  describe 'GET #simple_events' do
    let!(:simple_events) { create_list :simple_event, 2, visibility: 'public' }

    describe 'Authenticated user' do
      let(:user) { create :user }

      before do
        login user
        get :simple_events, format: :json
      end

      it 'assign an array of all public simple events' do
        expect(assigns(:simple_events)).to match_array simple_events
      end

      it 'respond with json format' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'returns status :ok' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'Unauthenticated user' do
      before { get :simple_events, format: :json }

      it 'does not assign an array of all public simple events' do
        expect(assigns(:simple_events)).to_not match_array simple_events
      end

      it 'returns status :unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end

require 'rails_helper'

RSpec.describe UserEventsController, type: :controller do
  describe 'GET #simple' do
    let(:user) { create :user }
    let!(:simple_events) do
      create_list :simple_event, 2, visibility: 'public', user: user
    end

    describe 'Authenticated user' do
      before do
        login user
        get :simple, format: :json
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
      before { get :simple, format: :json }

      it 'does not assign an array of all public simple events' do
        expect(assigns(:simple_events)).to_not match_array simple_events
      end

      it 'returns status :unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end

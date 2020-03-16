require 'rails_helper'

RSpec.describe CalendarController, type: :controller do

  let(:event) { create(:event) }

  describe 'GET #simple_events' do
    let(:events) { create_list(:event, 2, visibility: 'public') }

    before { get :simple_events, format: :json }

    it 'show an array of all questions' do
      expect(assigns(:events)).to match_array(events)
    end

    it 'render simple_events view' do
      expect(response).to render_template :simple_events
    end

    it 'respond with json format' do
      expect(response.content_type).to eq 'application/json'
    end

    it 'returns status :ok' do
      expect(response).to have_http_status(:ok)
    end
  end

end

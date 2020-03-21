require 'rails_helper'

RSpec.describe CalendarsController, type: :controller do
  let(:simple_event) { create :simple_event }
  let(:recurring_event) { create :recurring_event }

  describe 'GET #calendar' do
    before { get :calendar }

    it 'assign new simple event' do
      expect(assigns(:simple_event)).to be_a_new(SimpleEvent)
    end

    it 'assign new recurring event' do
      expect(assigns(:recurring_event)).to be_a_new(RecurringEvent)
    end

    it 'render calendar view' do
      expect(response).to render_template :calendar
    end

    it 'respond with html format' do
      expect(response.content_type).to eq 'text/html'
    end

    it 'returns status :ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #simple_events' do
    let(:simple_event) { create_list :simple_event, 2, visibility: 'public' }

    before { get :simple_events, format: :json }

    it 'show an array of all public simple events' do
      expect(assigns(:simple_events)).to match_array simple_event
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

  describe 'GET #recurring_events' do
    let(:recurring_events) do
      create_list :recurring_event, 2, :daily, visibility: 'public'
    end

    before { get :recurring_events, format: :json }

    it 'show an array of public recurring_events' do
      expect(assigns(:recurring_events)).to match_array recurring_events
    end

    it 'render recurring_events view' do
      expect(response).to render_template :recurring_events
    end

    it 'respond with json format' do
      expect(response.content_type).to eq 'application/json'
    end

    it 'returns status :ok' do
      expect(response).to have_http_status :ok
    end
  end
end

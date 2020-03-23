require 'rails_helper'

RSpec.describe CalendarsController, type: :controller do
  let(:user) { create :user }

  describe 'GET #show' do
    describe 'Authenticated user' do
      before do
        login user
        get :show
      end

      it 'assign new simple event' do
        expect(assigns(:simple_event)).to be_a_new SimpleEvent
      end

      it 'assign new recurring event' do
        expect(assigns(:recurring_event)).to be_a_new RecurringEvent
      end

      it 'render show view' do
        expect(response).to render_template :show
      end

      it 'respond with html format' do
        expect(response.content_type).to eq 'text/html'
      end

      it 'returns status :ok' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'Unauthenticated user' do
      before { get :show }

      it 'does not assign new simple event' do
        expect(assigns(:simple_event)).to_not be_a_new SimpleEvent
      end

      it 'does not assign new recurring event' do
        expect(assigns(:recurring_event)).to_not be_a_new RecurringEvent
      end

      it 'does not render show view' do
        expect(response).to_not render_template :show
      end

      it 'respond with html format' do
        expect(response.content_type).to eq 'text/html'
      end

      it 'returns status :redirect' do
        expect(response).to have_http_status :redirect
      end
    end
  end

  describe 'GET #simple_events' do
    let!(:simple_events) { create_list :simple_event, 2, visibility: 'public' }

    describe 'Authenticated user' do
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

      it 'respond with json format' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'returns status :unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe 'GET #recurring_events' do
    let!(:recurring_events) do
      create_list :recurring_event, 2, :daily, visibility: 'public'
    end

    describe 'Authenticated user' do
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

      it 'respond with json format' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'returns status :unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end

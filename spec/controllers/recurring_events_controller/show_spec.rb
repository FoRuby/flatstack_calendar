require 'rails_helper'

RSpec.describe RecurringEventsController, type: :controller do
  describe 'GET #show' do
    let(:recurring_event) do
      create :recurring_event, :daily, start_date: Date.today + 5
    end
    let(:next_date) { recurring_event.next_date(recurring_event.start_date) }
    let(:user) { create :user }
    let(:params) do
      { id: recurring_event, event: { start_date: recurring_event.start_date } }
    end

    describe 'Authenticated user' do
      before do
        login user
        get :show, params: params, format: :js, xhr: true
      end

      it 'assign the recurring event to @recurring_event' do
        expect(assigns(:recurring_event)).to eq recurring_event
      end

      it 'assign the requested next_date to @next_date' do
        expect(assigns(:next_date)).to eq next_date
      end

      it 'render show view' do
        expect(response).to render_template :show
      end

      it 'respond with js format' do
        expect(response.content_type).to eq 'text/javascript'
      end

      it 'returns status :ok' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'Unauthenticated user' do
      before { get :show, params: params, format: :js, xhr: true }

      it 'does not assign the requested recurring_event to @recurring_event' do
        expect(assigns(:recurring_event)).to_not eq recurring_event
      end

      it 'does not assign the requested next_date to @next_date' do
        expect(assigns(:next_date)).to_not eq next_date
      end

      it 'returns status :unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end

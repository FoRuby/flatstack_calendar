require 'rails_helper'

RSpec.describe SimpleEventsController, type: :controller do
  describe 'GET #show' do
    let(:simple_event) { create :simple_event }

    describe 'Authenticated user' do
      let(:user) { create :user }

      before do
        login user
        get :show, params: { id: simple_event }, format: :js, xhr: true
      end

      it 'assign the requested simple_event to @simple_event' do
        expect(assigns(:simple_event)).to eq simple_event
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
      before do
        get :show, params: { id: simple_event }, format: :js, xhr: true
      end

      it 'does not assign the requested simple_event to @simple_event' do
        expect(assigns(:simple_event)).to_not eq simple_event
      end

      it 'returns status :unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end

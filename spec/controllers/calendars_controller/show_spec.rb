RSpec.describe CalendarsController, type: :controller do

  describe 'GET #show' do
    describe 'Authenticated user' do
      let(:user) { create :user }

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

      it 'returns status :redirect' do
        expect(response).to have_http_status :redirect
      end
    end
  end
end

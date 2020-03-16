require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:event) { create(:event) }

  describe 'GET #index' do
    let(:events) { create_list(:event, 2) }

    before { get :index, format: :json }

    it 'show an array of all questions' do
      expect(assigns(:events)).to match_array(events)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end

    it 'respond with json format' do
      expect(response.content_type).to eq 'application/json'
    end

    it 'returns status :ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: event }, format: :js, xhr: true }

    it 'assign the requested event to @event' do
      expect(assigns(:event)).to eq event
    end

    it 'render show view' do
      expect(response).to render_template :show
    end

    it 'respond with js format' do
      expect(response.content_type).to eq 'text/javascript'
    end

    it 'returns status :ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:params) do
        { event: attributes_for(:event, event_type: 'public'), format: :js }
      end

      before { post :create, params: params }

      it 'save event in db' do
        expect { post :create, params: params }.to change(Event, :count)
      end

      it 'render create view' do
        expect(response).to render_template :create
      end

      it 'respond with js format' do
        expect(response.content_type).to eq 'text/javascript'
      end

      it 'returns status :ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid attributes' do
      let(:params) do
        { event: attributes_for(:event, :invalid_event), format: :js }
      end

      before { post :create, params: params }

      it 'does not save event in db' do
        expect { post :create, params: params }.to_not change(Event, :count)
      end

      it 'render create view' do
        expect(response).to render_template :create
      end

      it 'respond with js format' do
        expect(response.content_type).to eq 'text/javascript'
      end

      it 'returns status :ok' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:event) { create(:event) }
    let(:params) { { id: event, format: :js } }

    it 'delete event from db' do
      expect { delete :destroy, params: params }.to change(Event, :count)
    end

    it 'render destroy view' do
      delete :destroy, params: params

      expect(response).to render_template :destroy
    end

    it 'respond with js format' do
      delete :destroy, params: params

      expect(response.content_type).to eq 'text/javascript'
    end

    it 'returns status :ok' do
      delete :destroy, params: params

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #new' do
    before { get :new, format: :js, xhr: true }

    it 'assign the new event to @event' do
      expect(assigns(:event)).to be_a_new(Event)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end

    it 'respond with js format' do
      expect(response.content_type).to eq 'text/javascript'
    end

    it 'returns status :ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      let(:event_attributes) { attributes_for(:event) }

      before do
        patch :update, params: {
          id: event,
          event: attributes_for(:event, event_type: 'public'),
          format: :js
        }
      end

      it 'assign the requested event to @event' do
        expect(assigns(:event)).to eq(event)
      end

      it 'change event attributes' do
        expect { event.reload } .to change(event, :title)
          .and change(event, :title)
          .and change(event, :description)
          .and change(event, :start_date)
          .and change(event, :end_date)
          .and change(event, :event_type)
          .and change(event, :color)
      end

      it 'render update view' do
        expect(response).to render_template :update
      end

      it 'respond with js format' do
        expect(response.content_type).to eq 'text/javascript'
      end

      it 'returns status :ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid attributes' do
      let(:params) do
        {
          id: event,
          event: attributes_for(:event, :invalid_event),
          format: :js
        }
      end
      before { patch :update, params: params }

      it 'does not change event attributes' do
        expect { patch :update, params: params }.to not_change(event, :title)
          .and not_change(event, :start_date)
          .and not_change(event, :end_date)
          .and not_change(event, :event_type)
          .and not_change(event, :color)
      end

      it 'render update view' do
        expect(response).to render_template :update
      end

      it 'respond with js format' do
        expect(response.content_type).to eq 'text/javascript'
      end

      it 'returns status :ok' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end

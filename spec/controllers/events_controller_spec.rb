require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:event) { create(:event) }

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
        { event: attributes_for(:event), format: :js }
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
      before do
        patch :update, params: {
          id: event,
          event: build(:recurring_event,
                       :monthly,
                       date: Date.current,
                       duration: 10,
                       visibility: 'public').attributes,
          format: :js
        }
      end

      it 'assign the requested event to @event' do
        expect(assigns(:event)).to eq(event)
      end

      it 'change event attributes' do
        expect { event.reload }.to change(event, :title)
          .and change(event, :description)
          .and change(event, :date)
          .and change(event, :duration)
          .and change(event, :color)
          .and change(event, :recurring_start_date)
          .and change(event, :recurring_end_date)
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
          .and not_change(event, :recurring_start_date)
          .and not_change(event, :recurring_end_date)
          .and not_change(event, :visibility)
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

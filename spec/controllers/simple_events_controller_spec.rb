require 'rails_helper'

RSpec.describe SimpleEventsController, type: :controller do
  let(:simple_event) { create :simple_event }

  describe 'GET #show' do
    before { get :show, params: { id: simple_event }, format: :js, xhr: true }

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

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:params) do
        { event: attributes_for(:simple_event), format: :js }
      end

      before { post :create, params: params }

      it 'save simple_event in db' do
        expect { post :create, params: params }.to change(SimpleEvent, :count)
      end

      it 'render create view' do
        expect(response).to render_template :create
      end

      it 'respond with js format' do
        expect(response.content_type).to eq 'text/javascript'
      end

      it 'returns status :ok' do
        expect(response).to have_http_status :ok
      end
    end

    context 'with invalid attributes' do
      let(:params) do
        { event: attributes_for(:simple_event, :invalid_simple_event),
          format: :js }
      end

      before { post :create, params: params }

      it 'does not save simple_event in db' do
        expect { post :create, params: params }.to_not change(SimpleEvent, :count)
      end

      it 'render create view' do
        expect(response).to render_template :create
      end

      it 'respond with js format' do
        expect(response.content_type).to eq 'text/javascript'
      end

      it 'returns status :ok' do
        expect(response).to have_http_status :ok
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:simple_event) { create(:simple_event) }
    let(:params) { { id: simple_event, format: :js } }

    it 'delete simple_event from db' do
      expect { delete :destroy, params: params }.to change(SimpleEvent, :count)
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

      expect(response).to have_http_status :ok
    end
  end

  describe 'PATCH #update' do
    let(:simple_event) { create :simple_event }

    context 'with valid attributes' do
      before do
        patch :update, params: {
          id: simple_event,
          event: attributes_for(:simple_event, date: Date.current - 1,
                                               duration: 10,
                                               visibility: 'public'),
          format: :js
        }
      end

      it 'assign the requested simple_event to @simple_event' do
        expect(assigns(:simple_event)).to eq simple_event
      end

      it 'change simple_event attributes' do
        expect { simple_event.reload }
          .to change(simple_event, :title)
          .and change(simple_event, :description)
          .and change(simple_event, :color)
          .and change(simple_event, :date)
          .and change(simple_event, :duration)
      end

      it 'render update view' do
        expect(response).to render_template :update
      end

      it 'respond with js format' do
        expect(response.content_type).to eq 'text/javascript'
      end

      it 'returns status :ok' do
        expect(response).to have_http_status :ok
      end
    end

    context 'with invalid attributes' do
      let(:params) do
        {
          id: simple_event,
          event: attributes_for(:simple_event, :invalid_simple_event),
          format: :js
        }
      end
      before { patch :update, params: params }

      it 'does not change simple_event attributes' do
        expect { patch :update, params: params }
          .to not_change(simple_event, :title)
          .and not_change(simple_event, :visibility)
          .and not_change(simple_event, :color)
          .and not_change(simple_event, :date)
          .and not_change(simple_event, :duration)
      end

      it 'render update view' do
        expect(response).to render_template :update
      end

      it 'respond with js format' do
        expect(response.content_type).to eq 'text/javascript'
      end

      it 'returns status :ok' do
        expect(response).to have_http_status :ok
      end
    end
  end
end

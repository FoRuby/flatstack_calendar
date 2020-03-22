require 'rails_helper'

RSpec.describe RecurringEventsController, type: :controller do
  let(:recurring_event) do
    create :recurring_event, :daily, start_date: Date.today + 5
  end
  let(:next_date) { recurring_event.next_date(recurring_event.start_date) }

  describe 'GET #show' do
    let(:params) do
      { id: recurring_event, event: { start_date: recurring_event.start_date } }
    end

    before { get :show, params: params, format: :js, xhr: true }

    it 'assign the requested recurring_event to @recurring_event' do
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

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:params) do
        { event: attributes_for(:recurring_event), format: :js }
      end

      before { post :create, params: params }

      it 'save recurring_event in db' do
        expect { post :create, params: params }.to change(RecurringEvent, :count)
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
        { event: attributes_for(:recurring_event, :invalid_recurring_event),
          format: :js }
      end

      before { post :create, params: params }

      it 'does not save recurring_event in db' do
        expect { post :create, params: params }
          .to_not change(RecurringEvent, :count)
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
    let!(:recurring_event) { create(:recurring_event) }
    let(:params) { { id: recurring_event, format: :js } }

    it 'delete recurring_event from db' do
      expect { delete :destroy, params: params }.to change(RecurringEvent, :count)
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
    let(:recurring_event) { create :recurring_event, :daily }

    context 'with valid attributes' do
      before do
        patch :update, params: {
          id: recurring_event,
          event: attributes_for(
            :recurring_event, :monthly, start_date: Date.today + 5,
                                        end_date: Date.today + 60,
                                        visibility: 'public'
          ),
          format: :js
        }
      end

      it 'assign the requested recurring_event to @recurring_event' do
        expect(assigns(:recurring_event)).to eq recurring_event
      end

      it 'change recurring_event attributes' do
        expect { recurring_event.reload }
          .to change(recurring_event, :title)
          .and change(recurring_event, :description)
          .and change(recurring_event, :color)
          .and change(recurring_event, :start_date)
          .and change(recurring_event, :end_date)
          .and change(recurring_event, :recurrence)
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
          id: recurring_event,
          event: attributes_for(:recurring_event, :invalid_recurring_event),
          format: :js
        }
      end
      before { patch :update, params: params }

      it 'does not change recurring_event attributes' do
        expect { patch :update, params: params }
          .to not_change(recurring_event, :title)
          .and not_change(recurring_event, :visibility)
          .and not_change(recurring_event, :color)
          .and not_change(recurring_event, :start_date)
          .and not_change(recurring_event, :end_date)
          .and not_change(recurring_event, :recurrence)
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

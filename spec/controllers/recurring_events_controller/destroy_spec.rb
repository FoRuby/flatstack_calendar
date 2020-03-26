require 'rails_helper'

RSpec.describe RecurringEventsController, type: :controller do
  describe 'GET #destroy' do
    let(:author) { create :user }
    let!(:recurring_event) { create :recurring_event, user: author }
    let(:params) { { id: recurring_event, format: :js } }

    describe 'Authenticated' do
      context 'author' do
        before { login author }

        it 'delete recurring_event from db' do
          expect { delete :destroy, params: params }
            .to change(RecurringEvent, :count)
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

      context 'not author' do
        let(:user) { create :user }

        before { login user }

        it 'does not delete recurring_event from db' do
          expect { delete :destroy, params: params }
            .to_not change(RecurringEvent, :count)
        end

        it 'respond with html format' do
          delete :destroy, params: params

          expect(response.content_type).to eq 'text/html'
        end

        it 'returns status :redirect' do
          delete :destroy, params: params

          expect(response).to have_http_status :redirect
        end
      end
    end

    describe 'Unauthenticated user' do
      it 'does not assign the requested recurring_event to @recurring_event' do
        expect(assigns(:recurring_event)).to_not eq recurring_event
      end

      it 'does not delete recurring_event from db' do
        expect { delete :destroy, params: params }
          .to_not change(RecurringEvent, :count)
      end

      it 'returns status :unauthorized' do
        delete :destroy, params: params

        expect(response).to have_http_status :unauthorized
      end
    end
  end
end

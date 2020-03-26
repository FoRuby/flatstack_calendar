require 'rails_helper'

RSpec.describe SimpleEventsController, type: :controller do
  describe 'DELETE #destroy' do
    let(:author) { create :user }
    let!(:simple_event) { create :simple_event, user: author }
    let(:params) { { id: simple_event, format: :js } }

    describe 'Authenticated' do
      before { login author }

      context 'author' do
        it 'delete simple_event from db' do
          expect { delete :destroy, params: params }
            .to change(SimpleEvent, :count)
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

        it 'does not delete simple_event from db' do
          expect { delete :destroy, params: params }
            .to_not change(SimpleEvent, :count)
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
      it 'does not assign the requested simple_event to @simple_event' do
        expect(assigns(:simple_event)).to_not eq simple_event
      end

      it 'does not delete simple_event from db' do
        expect { delete :destroy, params: params }
          .to_not change(SimpleEvent, :count)
      end

      it 'returns status :unauthorized' do
        delete :destroy, params: params

        expect(response).to have_http_status :unauthorized
      end
    end
  end
end

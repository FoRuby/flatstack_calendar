require 'rails_helper'

RSpec.describe SimpleEventsController, type: :controller do
  describe 'POST #create' do
    describe 'Authenticated user' do
      let(:user) { create :user }

      context 'with valid attributes' do
        let(:params) do
          { event: attributes_for(:simple_event), format: :js }
        end

        before do
          login user
          post :create, params: params
        end

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

        before do
          login user
          post :create, params: params
        end

        it 'does not save simple_event in db' do
          expect { post :create, params: params }
            .to_not change(SimpleEvent, :count)
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

    describe 'Unauthenticated user' do
      let(:params) do
        { event: attributes_for(:simple_event), format: :js }
      end

      before { post :create, params: params }

      it 'does not save simple_event in db' do
        expect { post :create, params: params }
          .to_not change(SimpleEvent, :count)
      end

      it 'returns status :unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end

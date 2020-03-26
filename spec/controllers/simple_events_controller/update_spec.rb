require 'rails_helper'
RSpec.describe SimpleEventsController, type: :controller do
  describe 'PATCH #update' do
    let(:author) { create :user }
    let!(:simple_event) { create :simple_event, user: author }

    describe 'Authenticated' do
      context 'author' do
        context 'with valid attributes' do
          let(:params) do
            {
              id: simple_event,
              event: attributes_for(:simple_event),
              format: :js
            }
          end

          before do
            login author
            patch :update, params: params
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

          before do
            login author
            patch :update, params: params
          end

          it 'assign the requested simple_event to @simple_event' do
            expect(assigns(:simple_event)).to eq simple_event
          end

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

      context 'not author' do
        let(:user) { create :user }
        let(:params) do
          {
            id: simple_event,
            event: attributes_for(:simple_event),
            format: :js
          }
        end

        before do
          login user
          patch :update, params: params
        end

        it 'assign the requested simple_event to @simple_event' do
          expect(assigns(:simple_event)).to eq simple_event
        end

        it 'does not change simple_event attributes' do
          expect { patch :update, params: params }
            .to not_change(simple_event, :title)
            .and not_change(simple_event, :visibility)
            .and not_change(simple_event, :color)
            .and not_change(simple_event, :date)
            .and not_change(simple_event, :duration)
        end

        it 'respond with html format' do
          expect(response.content_type).to eq 'text/html'
        end

        it 'returns status :redirect' do
          expect(response).to have_http_status :redirect
        end

      end
    end

    describe 'Unauthenticated user' do
      let(:params) do
        {
          id: simple_event,
          event: attributes_for(:simple_event),
          format: :js
        }
      end

      before { patch :update, params: params }

      it 'does not assign the requested simple_event to @simple_event' do
        expect(assigns(:simple_event)).to_not eq simple_event
      end

      it 'returns status :unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end

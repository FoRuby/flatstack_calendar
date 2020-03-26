require 'rails_helper'

RSpec.describe RecurringEventsController, type: :controller do
  describe 'GET #update' do
    let(:author) { create :user }
    let(:recurring_event) { create :recurring_event, :daily, user: author }

    describe 'Authenticated' do
      context 'author' do
        context 'with valid attributes' do
          let(:params) do
            {
              id: recurring_event,
              event: attributes_for(:recurring_event, :monthly),
              format: :js
            }
          end

          before do
            login author
            patch :update, params: params
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

          before do
            login author
            patch :update, params: params
          end

          it 'assign the requested recurring_event to @recurring_event' do
            expect(assigns(:recurring_event)).to eq recurring_event
          end

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

      context 'not author' do
        let(:user) { create :user }
        let(:params) do
          {
            id: recurring_event,
            event: attributes_for(:recurring_event, :monthly),
            format: :js
          }
        end

        before do
          login user
          patch :update, params: params
        end

        it 'assign the requested recurring_event to @recurring_event' do
          expect(assigns(:recurring_event)).to eq recurring_event
        end

        it 'does not change recurring_event attributes' do
          expect { patch :update, params: params }
            .to not_change(recurring_event, :title)
            .and not_change(recurring_event, :visibility)
            .and not_change(recurring_event, :color)
            .and not_change(recurring_event, :start_date)
            .and not_change(recurring_event, :end_date)
            .and not_change(recurring_event, :recurrence)
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
          id: recurring_event,
          event: attributes_for(:recurring_event, :monthly),
          format: :js
        }
      end

      before { patch :update, params: params }

      it 'does not assign the requested recurring_event to @recurring_event' do
        expect(assigns(:recurring_event)).to_not eq recurring_event
      end

      it 'returns status :unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end

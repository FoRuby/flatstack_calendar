require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'GET #index' do
    before { get :index }
    it 'render index view' do
      expect(response).to render_template :index
    end

    it 'respond with html format' do
      expect(response.content_type).to eq 'text/html'
    end

    it 'returns http success' do
      expect(response).to have_http_status :ok
    end
  end
end

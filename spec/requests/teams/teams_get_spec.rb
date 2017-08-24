require 'rails_helper'

RSpec.describe '/api/v1/teams', type: :request do
  include_context 'client authenticated'

  describe 'GET teams' do
    let!(:team) { create(:team) }

    before do
      get '/api/v1/teams', headers: header
    end

    it { expect(response).to have_http_status(:ok) }
  end
end

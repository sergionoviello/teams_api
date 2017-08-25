require 'rails_helper'

RSpec.describe '/api/v1/projects', type: :request do
  include_context 'client authenticated'

  describe 'GET projects' do
    let!(:team) { create(:team) }
    let!(:project) { create(:project, team: team) }

    before do
      get '/api/v1/projects', headers: header
    end

    it { expect(response).to have_http_status(:ok) }

    it { expect(json['data'][0]['relationships']['team']).to be_present }
  end
end

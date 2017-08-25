require 'rails_helper'

RSpec.describe '/api/v1/teams/:id', type: :request do
  include_context 'client authenticated'

  describe 'DELETE /api/v1/teams/:id' do
    context 'when team has no prjects' do
      let(:team) { create(:team) }

      before do
        delete "/api/v1/teams/#{team.id}", headers: header
      end

      it { expect(response).to have_http_status(:no_content) }

      it 'updates the name' do
        expect(Team.count).to eq(0)
      end
    end

    context 'when has projects' do
      let(:team) { create(:team) }
      let!(:project) { create(:project, team: team) }

      before do
        delete "/api/v1/teams/#{team.id}", headers: header
      end

      it { expect(Team.count).to eq(1) }
      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end
end

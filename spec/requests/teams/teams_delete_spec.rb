require 'rails_helper'

RSpec.describe '/api/v1/teams/:id', type: :request do
  include_context 'client authenticated'

  describe 'DELETE /api/v1/teams/:id' do
    context 'when team has no projects and no employees' do
      let(:team) { create(:team) }

      before do
        delete "/api/v1/teams/#{team.id}", headers: header
      end

      it { expect(response).to have_http_status(:no_content) }

      it 'deletes' do
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

    context 'when has employees' do
      let(:team) { create(:team) }
      let!(:employee) { create(:employee, team: team) }

      before do
        delete "/api/v1/teams/#{team.id}", headers: header
      end

      it { expect(Team.count).to eq(1) }
      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'when resource does not exist' do
      before do
        delete '/api/v1/teams/-1', headers: header
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe '/api/v1/teams/:id/relationships/projects' do
    let(:team) { create(:team) }
    let(:project) { create(:project, team: team) }
    let!(:other_project) { create(:project, team: team) }

    let(:body) do
      {
        data: [
          { type: 'projects', id: project.id }
        ]
      }
    end

    before do
      delete "/api/v1/teams/#{team.id}/relationships/projects", headers: header
    end

    it { expect(team.projects.count).to eq(1) }
    it { expect(team.projects.last.title).to eq(other_project.title) }
  end
end

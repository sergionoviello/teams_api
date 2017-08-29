require 'rails_helper'

RSpec.describe '/api/v1/projects/:id', type: :request do
  include_context 'client authenticated'

  describe 'DELETE /api/v1/projects/:id' do
    context 'when team has 1 project' do
      let(:team) { create(:team) }
      let(:project) { create(:project, team: team) }

      before do
        delete "/api/v1/projects/#{project.id}", headers: header
      end

      it { expect(response).to have_http_status(:no_content) }

      it 'deletes the project' do
        expect(Project.count).to eq(0)
      end
    end

    context 'when resource does not exist' do
      before do
        delete '/api/v1/projects/-1', headers: header
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe '/team/:id/relationships/projects' do
    let(:team) { create(:team) }
    let(:project) { create(:project, team: team) }

    let(:body) do
      {
        data: {
          type: 'projects', id: project.id
        }
      }
    end

    before do
      delete "/api/v1/teams/#{team.id}/relationships/projects", headers: header
    end

    it { expect(team.projects.count).to eq(0) }
  end
end

require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :request do
  include_context 'client authenticated'

  describe '/api/v1/projects' do
    let(:team) { create(:team) }
    let(:body) do
      {
        data: {
          type: 'projects',
          relationships: {
            team: {
              data: {
                type: 'teams',
                id: team.id
              }
            }
          },
          attributes: {
            title: 'New project',
            description: 'cool project'
          }
        }
      }
    end

    before do
      post '/api/v1/projects', params: body.to_json, headers: header
    end

    it_behaves_like 'it responds with created status', 'projects'

    context 'when is not authorized' do
      let(:token) { '' }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end

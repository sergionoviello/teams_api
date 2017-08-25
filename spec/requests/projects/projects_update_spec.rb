require 'rails_helper'

RSpec.describe '/api/v1/projects/:id', type: :request do
  include_context 'client authenticated'

  let(:team) { create(:team) }
  let(:project) { create(:project, team: team) }

  describe 'PATCH /api/v1/projects/:id' do
    let(:body) do
      {
        data: {
          type: 'projects',
          id: project.id,
          attributes: {
            title: 'New Name'
          }
        }
      }
    end

    before do
      patch "/api/v1/projects/#{project.id}", params: body.to_json, headers: header
    end

    it_behaves_like 'it responds with created status', 'projects'

    it 'updates the name' do
      project.reload
      expect(project.title).to eq('New Name')
    end

    context 'when data is malformed' do
      let(:body) { {} }

      it_behaves_like 'bad request'
    end

    context 'when resource does not exist' do
      let(:body) do
        {
          data: {
            type: 'projects',
            id: 99999,
            attributes: {
              title: 'New Name'
            }
          }
        }
      end

      it_behaves_like 'bad request'
    end
  end
end

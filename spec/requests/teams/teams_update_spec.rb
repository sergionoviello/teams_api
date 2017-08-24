require 'rails_helper'

RSpec.describe '/api/v1/teams/:id', type: :request do
  include_context 'client authenticated'

  let(:team) { create(:team) }

  describe 'PATCH /api/v1/teams/:id' do
    let(:body) do
      {
        data: {
          type: 'teams',
          id: team.id,
          attributes: {
            name: 'New Name'
          }
        }
      }
    end

    before do
      patch "/api/v1/teams/#{team.id}", params: body.to_json, headers: header
    end

    it_behaves_like 'it responds with created status', 'teams'

    it 'updates the name' do
      team.reload
      expect(team.name).to eq('New Name')
    end

    context 'when data is malformed' do
      let(:body) { {} }

      it_behaves_like 'bad request'
    end

    context 'when resource does not exist' do
      let(:body) do
        {
          data: {
            type: 'teams',
            id: 99999,
            attributes: {
              name: 'New Name'
            }
          }
        }
      end

      it_behaves_like 'bad request'
    end
  end
end

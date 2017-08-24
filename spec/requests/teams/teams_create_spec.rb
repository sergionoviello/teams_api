require 'rails_helper'

RSpec.describe '/api/v1/teams', type: :request do
  include_context 'client authenticated'

  describe 'POST /api/v1/teams' do
    let(:body) do
      {
        data: {
          type: 'teams',
          attributes: {
            name: 'Pegasus',
            description: 'delivery team'
          }
        }
      }
    end

    before do
      post '/api/v1/teams', params: body.to_json, headers: header
    end

    it_behaves_like 'it responds with created status', 'teams'

    context 'when is not authorized' do
      let(:token) { '' }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when data is malformed' do
      let(:body) { { data: {} } }

      it_behaves_like 'bad request'
    end

    context 'when required field is missing' do
      let(:body) do
        { data: { attributes: { description: 'test' } } }
      end

      it_behaves_like 'bad request'
    end
  end
end

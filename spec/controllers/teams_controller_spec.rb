require 'rails_helper'

RSpec.describe Api::V1::TeamsController, type: :request do
  describe 'POST create teams' do
    let(:user) { create(:user, email: 'example@mail.com', password: '123123123') }
    let(:token) { AuthenticateUser.new(user.email, user.password).call }

    before do
      body = {
        data: {
          type: 'teams',
          attributes: {
            name: 'Pegasus',
            description: 'delivery team'
          }
        }
      }

      post '/api/v1/teams',
           params: body.to_json,
           headers: {
             'Accept' => 'application/vnd.api+json',
             'Content-type' => 'application/vnd.api+json',
             'Authorization' => token
           }
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(json['data']['type']).to eq('teams') }

    context 'when is not authorized' do
      let(:token) { '' }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end

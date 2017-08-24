require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :request do
  describe 'POST create projects' do
    let(:user) { create(:user, email: 'example@mail.com', password: '123123123') }
    let(:team) { create(:team) }
    let(:token) { AuthenticateUser.new(user.email, user.password).call }

    before do
      body = {
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

      post '/api/v1/projects',
           params: body.to_json,
           headers: {
             'Accept' => 'application/vnd.api+json',
             'Content-type' => 'application/vnd.api+json',
             'Authorization' => token
           }
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(json['data']['type']).to eq('projects') }

    context 'when is not authorized' do
      let(:token) { '' }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end

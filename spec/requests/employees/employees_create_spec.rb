require 'rails_helper'

RSpec.describe Api::V1::EmployeesController, type: :request do
  include_context 'client authenticated'

  describe '/api/v1/employees' do
    let(:team) { create(:team) }
    let(:body) do
      {
        data: {
          type: 'employees',
          relationships: {
            team: {
              data: {
                type: 'teams',
                id: team.id
              }
            }
          },
          attributes: {
            'first-name' => Faker::Name.first_name,
            'last-name' => Faker::Name.last_name,
            'email' => Faker::Internet.email
          }
        }
      }
    end

    before do
      post '/api/v1/employees', params: body.to_json, headers: header
    end

    it_behaves_like 'it responds with created status', 'employees'

    context 'when is not authorized' do
      let(:token) { '' }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end

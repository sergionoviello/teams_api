require 'rails_helper'

RSpec.describe '/api/v1/employees/:id', type: :request do
  include_context 'client authenticated'

  let(:team) { create(:team) }
  let(:employee) { create(:employee, team: team) }

  describe 'PATCH /api/v1/employees/:id' do
    let(:body) do
      {
        data: {
          type: 'employees',
          id: employee.id,
          attributes: {
            'first-name' => 'New Name'
          }
        }
      }
    end

    before do
      patch "/api/v1/employees/#{employee.id}", params: body.to_json, headers: header
    end

    it_behaves_like 'it responds with created status', 'employees'

    it 'updates the name' do
      employee.reload
      expect(employee.first_name).to eq('New Name')
    end

    context 'when data is malformed' do
      let(:body) { {} }

      it_behaves_like 'bad request'
    end

    context 'when resource does not exist' do
      let(:body) do
        {
          data: {
            type: 'employees',
            id: 99999,
            attributes: {
              'first-name' => 'New Name'
            }
          }
        }
      end

      it_behaves_like 'bad request'
    end
  end
end

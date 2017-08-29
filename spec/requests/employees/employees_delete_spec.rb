require 'rails_helper'

RSpec.describe '/api/v1/employees/:id', type: :request do
  include_context 'client authenticated'

  describe 'DELETE /api/v1/employees/:id' do
    context 'when team has 1 employee' do
      let(:team) { create(:team) }
      let(:employee) { create(:employee, team: team) }

      before do
        delete "/api/v1/employees/#{employee.id}", headers: header
      end

      it { expect(response).to have_http_status(:no_content) }

      it 'deletes the employee' do
        expect(Employee.count).to eq(0)
      end
    end

    context 'when resource does not exist' do
      before do
        delete '/api/v1/employees/-1', headers: header
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe '/team/:id/relationships/employees' do
    let(:team) { create(:team) }
    let(:employee) { create(:employee, team: team) }

    let(:body) do
      {
        data: {
          type: 'employees', id: employee.id
        }
      }
    end

    before do
      delete "/api/v1/teams/#{team.id}/relationships/employees", headers: header
    end

    it { expect(team.employees.count).to eq(0) }
  end
end

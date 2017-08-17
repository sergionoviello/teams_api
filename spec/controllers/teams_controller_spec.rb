require 'rails_helper'
include JSONAPI::ActsAsResourceController

RSpec.describe TeamsController, type: :controller do
  describe 'teams' do
    it 'should allow simple path and verify only that path' do
      get 'http://localhost:3000/api/v1/teams'
      expect_json_types('teams', attributes: :object)
      
    end
  end
end

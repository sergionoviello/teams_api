# frozen_string_literal: true

RSpec.shared_examples 'bad request' do
  it { expect(response).to have_http_status(:bad_request) }
end

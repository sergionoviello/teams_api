# frozen_string_literal: true

RSpec.shared_examples 'it responds with created status' do |type|
  it 'responds with status code :success' do
    expect(response).to have_http_status(:success)
  end

  it 'respond with content type application/json' do
    expect(json['data']['type']).to eq(type)
  end
end

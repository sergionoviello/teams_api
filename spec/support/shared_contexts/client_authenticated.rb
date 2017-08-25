# frozen_string_literal: true

RSpec.shared_context 'client authenticated' do
  let(:user) { create(:user, email: 'example@mail.com', password: '123123123') }
  let(:token) { AuthenticateUser.new(user.email, user.password).call }
  let(:header) do
    { 'Accept' => 'application/vnd.api+json', 'Content-type' => 'application/vnd.api+json', 'Authorization' => token }
  end
end

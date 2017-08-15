require 'rails_helper'

# frozen_string_literal: true
RSpec.describe AuthController, type: :controller do
  let(:authenticate_user) { instance_double(AuthenticateUser) }
  let(:token) { '123' }

  before do
    allow(AuthenticateUser).to receive(:new).and_return(authenticate_user)
    allow(authenticate_user).to receive(:call).and_return(token)
  end

  describe '#authenticate' do
    subject { post :authenticate, params: { email: 'abc@gmail.com', password: 'abc' } }

    it 'validates assumptions' do
      subject
      expect(AuthenticateUser).to have_received(:new).with('abc@gmail.com', 'abc')
      expect(authenticate_user).to have_received(:call).with(no_args)
    end

    it 'lists all bookmarked items for the current user' do
      subject
      expect(JSON.parse(response.body)).to be_an_instance_of(Hash)
      expect(JSON.parse(response.body)).to include('auth_token' => token)
    end

    context 'when credentials are invalid' do
      before do
        allow(authenticate_user).to receive(:call).and_return(nil)
      end

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end

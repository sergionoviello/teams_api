require 'rails_helper'

# frozen_string_literal: true

RSpec.describe AuthorizeApiRequest do
  subject(:auth_api_request) { described_class.new(headers) }

  let(:headers) { {} }
  let(:user) { create(:user, password: '123') }
  let(:params) { { user_id: user.id } }

  before do
    allow(JsonWebToken).to receive(:decode).and_return(params)
  end

  describe '#call' do
    it 'returns the user by token' do
      expect(subject.call).to eq(user)
    end

    context 'when user is not found' do
      let(:params) { nil }

      it { expect(subject.call).to eq(nil) }
    end
  end
end

require 'rails_helper'

# frozen_string_literal: true

RSpec.describe AuthenticateUser do
  subject(:auth_user) { described_class.new(user.email, user.password) }

  let(:user) { create(:user, password: 'abc') }

  before do
    allow(JsonWebToken).to receive(:encode).and_return('123')
  end

  describe '#call' do
    it 'encodes token' do
      subject.call

      expect(JsonWebToken).to have_received(:encode).with(user_id: user.id)
    end

    context 'when user is nil' do
      subject(:auth_user) { described_class.new('abc@gmail.com', user.password) }

      it 'does not encode token' do
        subject.call
        expect(JsonWebToken).not_to have_received(:encode)
      end
    end
  end
end

require 'rails_helper'

# frozen_string_literal: true

RSpec.describe User, type: :model do
  subject { described_class.new }

  context 'validations' do
    subject { build_stubbed(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    context 'unique email' do
      subject { create(:user, password: '123') }
      let(:invalid_user) { build(:user, email: subject.email, password: '123 ') }

      it { is_expected.to validate_uniqueness_of(:email) }
      it { expect(invalid_user.valid?).to eq(false) }
    end
  end
end

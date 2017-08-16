require 'rails_helper'

RSpec.describe Employee, type: :model do
  subject { described_class.new }

  context 'validation' do
    subject { build_stubbed(:employee) }

    it { is_expected.to validate_presence_of(:email) }

    context 'unique email' do
      subject { create(:employee) }
      let(:invalid_employee) { build(:employee, email: subject.email) }

      it { is_expected.to validate_uniqueness_of(:email) }
      it { expect(invalid_employee.valid?).to eq(false) }
    end
  end

  describe '.full_name' do
    subject { build_stubbed(:employee, first_name: 'Joe', last_name: 'Black') }

    it { expect(subject.full_name).to eq('Joe Black') }

    context 'when first_name is empty' do
      subject { build_stubbed(:employee, first_name: nil, last_name: 'Black') }

      it { expect(subject.full_name).to eq('Black') }
    end

    context 'when last_name is empty' do
      subject { build_stubbed(:employee, first_name: 'Joe', last_name: nil) }

      it { expect(subject.full_name).to eq('Joe') }
    end

    context 'when both are empty' do
      subject { build_stubbed(:employee, first_name: nil, last_name: nil) }

      it { expect(subject.full_name).to eq('') }
    end
  end
end

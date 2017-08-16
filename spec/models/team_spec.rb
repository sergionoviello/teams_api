require 'rails_helper'

RSpec.describe Team, type: :model do
  subject { described_class.new }

  context 'validation' do
    subject { build_stubbed(:team) }

    it { is_expected.to validate_presence_of(:name) }

    context 'unique name' do
      subject { create(:team) }
      let(:invalid_team) { build(:team, name: subject.name) }

      it { is_expected.to validate_uniqueness_of(:name) }
      it { expect(invalid_team.valid?).to eq(false) }
    end
  end
end

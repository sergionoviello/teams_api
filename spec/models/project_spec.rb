require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:team) }
  end

  context 'validation' do
    subject { build_stubbed(:project) }

    it { is_expected.to validate_presence_of(:title) }
  end
end

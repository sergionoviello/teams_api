require 'rails_helper'

RSpec.describe Api::V1::TeamResource, type: :resource do
  let(:team) { create(:team) }
  subject { described_class.new(team, {}) }

  it { is_expected.to have_attribute(:name) }
  it { is_expected.to have_attribute(:description) }
  it { is_expected.to have_many(:projects).with_class_name('Project') }
end

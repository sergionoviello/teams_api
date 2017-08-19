require 'rails_helper'

RSpec.describe Api::V1::ProjectResource, type: :resource do
  let(:team) { create(:team) }
  let(:project) { create(:project, team: team) }
  subject { described_class.new(project, {}) }

  it { is_expected.to have_attribute(:title) }
  it { is_expected.to have_attribute(:description) }
  it { is_expected.to filter(:team) }
end

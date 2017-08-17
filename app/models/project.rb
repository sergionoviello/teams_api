# Project class
class Project < ApplicationRecord
  belongs_to :team

  validates :title, presence: true
end

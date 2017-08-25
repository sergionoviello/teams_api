# Taam
class Team < ApplicationRecord
  has_many :employees, dependent: :restrict_with_error
  has_many :projects, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end

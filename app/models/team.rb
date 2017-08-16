# Taam
class Team < ApplicationRecord
  has_many :employees

  validates :name, presence: true, uniqueness: true
end

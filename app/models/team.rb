# Taam
class Team < ApplicationRecord
  has_many :employees
  has_many :projects

  validates :name, presence: true, uniqueness: true
end

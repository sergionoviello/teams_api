# Employee
class Employee < ApplicationRecord
  belongs_to :team

  validates :email, presence: true, uniqueness: true

  def full_name
    [first_name, last_name].join(' ').strip
  end
end

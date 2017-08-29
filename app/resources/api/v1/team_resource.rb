module Api
  module V1
    # team resource
    class TeamResource < JSONAPI::Resource
      attributes :name, :description
      has_many :projects
      has_many :employees
    end
  end
end

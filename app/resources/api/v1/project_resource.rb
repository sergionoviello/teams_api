module Api
  module V1
    # project resource
    class ProjectResource < JSONAPI::Resource
      attributes :title, :description

      has_one :team

      filter :team
    end
  end
end

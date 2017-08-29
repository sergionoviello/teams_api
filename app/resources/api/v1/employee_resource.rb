module Api
  module V1
    # employee resource
    class EmployeeResource < JSONAPI::Resource
      attributes :full_name, :email, :first_name, :last_name

      has_one :team

      filter :team

      def fetchable_fields
        super - [:first_name, :last_name]
      end
    end
  end
end

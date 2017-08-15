# ApplicationController
class ApplicationController < ActionController::API
  before_action :auth_request

  private

  def auth_request
    @current_user = AuthorizeApiRequest.new(request.headers).call
    
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end

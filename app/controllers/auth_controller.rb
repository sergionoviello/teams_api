class AuthController < ApplicationController
  skip_before_action :auth_request

  def authenticate
    service = AuthenticateUser.new(params[:email], params[:password]).call

    return render json: { error: 'Invalid credentials' }, status: :unauthorized if service.nil?
    render json: { auth_token: service }
  end
end

# AuthorizeApiRequest

class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decode_auth_token[:user_id]) if decode_auth_token
    @user || nil
  end

  def decode_auth_token
    @decode_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    return nil if headers['Authorization'].blank?

    headers['Authorization'].split(' ').last
  end
end

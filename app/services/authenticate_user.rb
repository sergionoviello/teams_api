# AuthenticateUser
class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    return nil if user.nil?

    JsonWebToken.encode(user_id: user.id)
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
    nil
  end
end

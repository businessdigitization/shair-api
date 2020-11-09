class AuthenticateUser
  attr_accessor :auth_header

  def self.call(auth_header = {})
    new(auth_header).call
  end

  def initialize(auth_header)
    @auth_header = auth_header
  end

  def call
    user
  end

  private

  def user
    User.find_by(email: decoded_auth_token[:email]) if decoded_auth_token
  end

  def decoded_auth_token
    JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if auth_header.present?
      auth_header.split(' ').last
    end
  end
end

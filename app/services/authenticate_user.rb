class AuthenticateUser
  attr_accessor :headers

  def self.call(headers = {})
    new(headers).call
  end

  def initialize(headers)
    @headers = headers
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
    if headers['Authorization'].present?
      headers['Authorization'].split(' ').last
    end
  end
end

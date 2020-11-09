class GenerateAuthToken
  attr_accessor :email, :password

  def self.call(email, password)
    new(email, password).call
  end

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(email: user.email) if user
  end

  private

  def user
    user = User.find_by_email(email)
    return user if user && user.authenticate(password)
  end
end

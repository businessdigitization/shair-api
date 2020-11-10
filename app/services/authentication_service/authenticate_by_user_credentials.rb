module AuthenticationService
  class AuthenticateByUserCredentials
    def self.call(email, password)
      new(email, password).call
    end

    def call
      AuthenticationService::JsonWebTokenizer.encode(email: user.email) if user
    end

    private

    attr_accessor :email, :password

    def initialize(email, password)
      @email = email
      @password = password
    end

    def user
      user = User.find_by(email: email)
      return user if user && user.authenticate(password)
    end
  end
end

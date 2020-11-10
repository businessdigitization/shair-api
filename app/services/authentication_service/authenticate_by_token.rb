module AuthenticationService
  class AuthenticateByToken
    def self.call(token)
      new(token).call
    end

    def call
      user
    end

    private

    attr_accessor :token

    def initialize(token)
      @token = token
    end

    def user
      User.find_by(email: decoded_token[:email]) if decoded_token
    end

    def decoded_token
      AuthenticationService::JsonWebTokenizer.decode(token)
    end
  end
end

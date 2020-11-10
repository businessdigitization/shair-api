module Helpers
  def generate_auth_header(user = nil)
    user ||= FactoryBot.create(:user)
    auth_token = 'Bearer ' + AuthenticationService::AuthenticateByUserCredentials.call(user.email, user.password)
    { "Authorization" => auth_token }
  end
end

module Helpers
  def generate_access_token(user = nil)
    user ||= FactoryBot.create(:user)
    auth_token = 'Bearer ' + GenerateAuthToken.call(user.email, user.password)
    { "Authorization" => auth_token }
  end
end

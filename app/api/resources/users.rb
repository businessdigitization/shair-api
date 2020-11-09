module Resources
  class Users < Grape::API
    resources :users do
      desc 'Register'
      params do
        requires :name, type: String
        requires :email, type: String
        requires :password, type: String
      end

      post 'register' do

        user = User.create!(permitted_params)
        GenerateAuthToken.call(user.email, user.password)
      end

      desc 'Log in'
      params do
        requires :email, type: String
        requires :password, type: String
      end

      post 'log_in' do
        GenerateAuthToken.call(permitted_params[:email], permitted_params[:password])
      end
    end
  end
end

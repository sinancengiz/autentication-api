# app/controllers/authentication_controller.rb
class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  # return auth token once user is authenticated
  def authenticate
    user = User.find_by_email(auth_params[:email])
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call

    json_response(
      user:user, 
      auth_token: auth_token
    )
  end

  def logout
    render json: { message: 'Successfully logged out' }
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
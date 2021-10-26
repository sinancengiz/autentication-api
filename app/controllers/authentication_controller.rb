# app/controllers/authentication_controller.rb
class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  # return auth token once user is authenticated
  def authenticate
    user = User.find_by_email(auth_params[:email])
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(user:user, auth_token: auth_token)
  end

  def logout
    if current_user.current_game
      @game = Game.where(id: current_user.current_game).first
      @game.player_count -= 1
      @game.save
      current_user.current_game = nil
    end
    render json: { message: 'Successfully logged out' }, status: :ok
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
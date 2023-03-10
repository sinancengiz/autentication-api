# app/controllers/users_controller.rb
class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create, :register, :create_customer]
  # POST /register
  # return authenticated token upon signup
  def register
    begin
      user = User.create!({
        email: params[:email], 
        password: params[:password], 
        password_confirmation: params[:password_confirmation], 
        role: params[:role],
        first_name: params[:first_name],
        last_name: params[:last_name]
      })
      user.save!
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { 
        message: Message.account_created,
        user:user,
        auth_token: auth_token }
      json_response(response)
    rescue ActiveRecord::RecordInvalid => e
      json_response({ error: e.message }, :unprocessable_entity)
    end
  end

  private
end

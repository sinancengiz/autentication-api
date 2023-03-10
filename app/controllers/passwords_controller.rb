class PasswordsController < ApplicationController
  skip_before_action :authorize_request, only: [:forgot, :reset]
  def forgot
    begin
      user = User.where(email: params[:email]).first
      if user
        render json: { messsage: "We have sent you a password reset email." }, state: :ok
        user.send_password_reset
      else
        #this sends regardless of whether there's an email in database for security reasons
        render json: {
          message: "If this user exists, we have sent you a password reset email."
        }, state: :ok
      end
    rescue => e
      render json: {error: e.message, status: 500}.to_json
    end
  end

  def reset
    user = User.find_by(password_reset_token: params[:token], email: params[:email])
    if user.present? && user.password_token_valid?
      if user.reset_password(params[:password])
        render json: {
          message: "Your password has been successfuly reset!"
        }, state: :ok
      else
        render json: { error: user.errors.full_messages }
      end
    else
      render json: {error:  ['Link not valid or expired. Try generating a new link.']}
    end
  end

end
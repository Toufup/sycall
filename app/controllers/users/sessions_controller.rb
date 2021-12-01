# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # super
    user =  User.find_for_database_authentication(email: login_params[:email])

    return render json: {state: false} if user.nil?

    if user.valid_password?(login_params[:password])
      sign_in :user, user
      render json: {state: true}
    else
      render json: {state: false}
    end
  end

  # DELETE /resource/sign_out
  def destroy
    # super
    sign_out current_user
    render json: {state: true}
  end

  private
  def login_params
    params.require(:user).permit(:email, :password)
  end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

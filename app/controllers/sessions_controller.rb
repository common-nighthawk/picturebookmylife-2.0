class SessionsController < Devise::SessionsController
  skip_before_filter :require_no_authentication

  def create
    if params[:user][:email].include?('@')
      @user = User.find_by(email: params[:user][:email])
      flash[:error] = 'Sorry, there is no account associated with that email address.'
    else
      @user = User.find_by(username: params[:user][:email])
      flash[:error] = 'Sorry, there is no account associated with that username.'
    end

    if @user.blank?
      redirect_to root_path
    elsif @user.valid_password?(params[:user][:password])
      set_flash_message(:notice, :signed_in)
      self.resource = warden.authenticate!(auth_options)
      redirect_to welcome_nice_path
    else
      flash[:error] = 'Sorry, that password is incorrect.'
      redirect_to root_path
    end

    # self.resource = warden.authenticate!(auth_options)
    # set_flash_message(:notice, :signed_in) if is_flashing_format?
    # sign_in(resource_name, resource)
    # yield resource if block_given?
    # respond_with resource, location: after_sign_in_path_for(resource)
  end
end

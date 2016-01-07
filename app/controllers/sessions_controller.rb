class SessionsController < Devise::SessionsController
  skip_before_filter :require_no_authentication
  before_action :set_user, only: :create

  def new
    raise
  end

  def create
    if @user.blank?
      redirect_to root_path
    elsif @user.valid_password?(sign_in_params[:password])
      set_flash_message(:notice, :signed_in)
      # self.resource = warden.authenticate!(auth_options)
      sign_in(@user)
      redirect_to user_path(@user)
    else
      set_flash_error('wrong password')
      redirect_to root_path
    end
  end

  def destroy
    super
  end

  private

  def set_user
    if sign_in_params[:email].include?('@')
      @user = User.find_by(email: sign_in_params[:email])
      set_flash_error('no email') unless @user
    else
      @user = User.find_by(username: sign_in_params[:email])
      set_flash_error('no username') unless @user
    end
  end

  def set_flash_error(code)
    case code
    when 'no email'
      flash[:error] = 'Sorry, there is no account associated with that email address.'
    when 'no username'
      flash[:error] = 'Sorry, there is no account associated with that username.'
    when 'wrong password'
      flash[:error] = 'Sorry, that password is incorrect.'
    end
  end
end

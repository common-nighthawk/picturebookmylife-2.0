class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication

  def create
    build_resource(sign_up_params.merge(username: params[:user][:username]))

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        redirect_to user_path(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        redirect_to root_path
      end
    else
      flash[:alert] = resource.errors.full_messages.join('. ')
      redirect_to root_path
    end
  end

  def cancel
    raise
  end

  def new
    raise
  end

  def edit
    raise
  end

  def update
    raise
  end

  def destroy
    raise
  end
end

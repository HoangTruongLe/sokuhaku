# frozen_string_literal: true

class Admins::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, :raise => false
  skip_before_action :authenticate_admin!, :raise => false

  def new
    if admin_signed_in?
      super
    else
      redirect_to admin_session_path
    end
  end

  def sign_up_success
    render :sign_up_success
  end

  def after_inactive_sign_up_path_for(resource)
    '/admins/sign_up_success'
  end
end

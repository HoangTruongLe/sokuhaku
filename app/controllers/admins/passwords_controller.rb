# frozen_string_literal: true

class Admins::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  def update
    super do |resource|
      if resource.errors.full_messages.empty?
        begin
          ::Admins::ResetPasswordMailer.send_to(resource.email).deliver_later
        rescue StandardError => ex
          puts ex
        end
      end
    end
    sign_out(current_admin) if current_admin
  end

  protected

  def after_resetting_password_path_for(resource)
    admins_update_password_complete_path
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    admins_send_reset_password_instructions_complete_path
  end
end

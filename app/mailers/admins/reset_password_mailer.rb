module Admins
  class ResetPasswordMailer < ApplicationMailer
    default from: EasySettings.email.mail_address_info

    def send_to(email)
      begin
        mail(to: email, subject: 'SOKUHAKU|パスワード更新のお知らせ')
      rescue StandardError => se
        raise StandardError, se
      end
    end
  end
end

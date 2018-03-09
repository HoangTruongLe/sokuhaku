class DeviseMailer < Devise::Mailer
  default from: EasySettings.email.mail_address_info

  def reset_password_instructions(record, token, opts={})
   mail = super
   mail.subject = 'SOKUHAKU|パスワードリセット'
   
   mail
  end
end

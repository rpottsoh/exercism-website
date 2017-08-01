class DeviseMailer < Devise::Mailer
  def reset_password_instructions(user, token, options={})
    @user = user
    @token = token
    options[:subject] = "Reset password request from Flaunt"
    super
  end
end

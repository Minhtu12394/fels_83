class UserMailer < ApplicationMailer

  def account_activation user_hash
    @user_hash = user_hash
    mail  to: "#{user_hash[:name]} <#{user_hash[:email]}>",
      subject: "Account activation"
  end

  def password_reset user_hash
    @user_hash = user_hash
    mail  to: "#{user_hash[:name]} <#{user_hash[:email]}>",
      subject: "Password reset"
  end
end

class UserService
  def initialize(user)
    @user = user
  end

  def reset_password(current_password, new_password, confirm_new_password)
    if @user.valid_password?(current_password)
      if new_password == confirm_new_password
        if @user.update(password: new_password, password_confirmation: confirm_new_password)
          "Password Updated"
        else
          @user.errors.full_messages
        end
      else
        "New password and confirmation do not match"
      end
    else
      "Current Password Invalid"
    end
  end
end

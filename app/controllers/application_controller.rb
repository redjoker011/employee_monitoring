class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    user = resource
    if user.super_admin? || user.hr_staff?
      users_path
    else
      user_path(user)
    end
  end
end

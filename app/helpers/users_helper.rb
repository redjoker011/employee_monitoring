module UsersHelper
  def has_leave_credits?(credits)
    !credits.zero?
  end
end

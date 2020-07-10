module UsersHelper
  def has_leave_credits?(credits)
    !credits.zero?
  end

  def to_short_date(date)
    format = "%B %d, %Y"
    date.strftime(format)
  end
end

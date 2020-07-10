# == Schema Information
#
# Table name: leave_requests
#
#  id             :bigint           not null, primary key
#  category       :integer          default(0), not null
#  leave_end_at   :datetime
#  leave_start_at :datetime
#  reason         :text
#  status         :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
# Indexes
#
#  index_leave_requests_on_user_id  (user_id)
#
class LeaveRequest < ApplicationRecord
  belongs_to :user

  enum status: %i[pending declined approved]
  enum category: %i[vacation_leave sick_leave]

  validates :reason, :leave_end_at, :leave_start_at, presence: true
  validate :ensure_date_not_overlapped, on: :create

  def leave_in_days
    days = (leave_end_at.to_date - leave_start_at.to_date).to_i + 1
    return 1 if days.zero?

    days
  end

  private

  def ensure_date_not_overlapped
    return unless leave_start_at || leave_end_at

    not_less_than_today = leave_start_at.to_date >= Time.zone.today
    valid_date_range = leave_start_at.to_date >= leave_end_at.to_date
    return if not_less_than_today && valid_date_range

    errors.add(:base, "Leave Dates Overlapped")
  end
end

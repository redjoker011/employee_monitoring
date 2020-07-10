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
end

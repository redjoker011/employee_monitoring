class AddLeaveCreditsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :leave_credits, :integer, default: 0
  end
end

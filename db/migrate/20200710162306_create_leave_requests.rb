class CreateLeaveRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :leave_requests do |t|
      t.references :user, index: true
      t.integer :category, null: false, default: 0
      t.text :reason
      t.integer :status, null: false, default: 0
      t.datetime :leave_start_at
      t.datetime :leave_end_at
      t.timestamps
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  sequence :email do
    "#{Faker::Internet.safe_email}-#{Time.zone.now.to_i}"
  end

  sequence :username do
    FFaker::InternetSE.login_user_name
  end

  factory :user do
    email
    password { Devise.friendly_token.first(8) }
    role { "admin" }
  end
end

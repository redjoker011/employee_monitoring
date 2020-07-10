require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_presence_of(:role)
end

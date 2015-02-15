require 'test_helper'

class UserTest < ActiveSupport::TestCase
  it 'tests user is inactive' do
    users(:user_two).active.must_equal false
  end
end

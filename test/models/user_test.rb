require 'test_helper'

class UserTest < ActiveSupport::TestCase
  it 'tests user is inactive' do
    users(:user_two).active.must_equal false
  end
  it 'should have 1 unread message' do
    users(:user_one).unread_messages.size.must_equal 1
  end
end

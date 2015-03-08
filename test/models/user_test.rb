require 'test_helper'

class UserTest < ActiveSupport::TestCase
  it 'tests user is inactive' do
    users(:user_two).active.must_equal false
  end
  it 'user_one should have 1 unread message' do
    unread_messages = users(:user_one).unread_messages.size
    unread_messages.must_equal 1
  end
  it 'user_one should have 1 read message' do
    read_messages = users(:user_one).read_messages.size
    read_messages.must_equal 1
  end
  it 'user_one should have 2 messages' do
    messages = users(:user_one).messages.size
    messages.must_equal 2
  end
end

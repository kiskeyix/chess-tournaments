require 'test_helper'

class UserTest < ActiveSupport::TestCase
  it 'tests user is inactive' do
    assert_equal false, users(:user_two).active
  end
  it 'user_one should have 1 unread message' do
    unread_messages = users(:user_one).unread_messages.size
    assert_equal 1, unread_messages
  end
  it 'user_one should have 1 read message' do
    read_messages = users(:user_one).read_messages.size
    assert_equal 1, read_messages
  end
  it 'user_one should have 2 messages' do
    messages = users(:user_one).messages.size
    assert_equal 2, messages
  end
end

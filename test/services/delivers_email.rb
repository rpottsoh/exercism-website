require 'test_helper'

class DeliversEmailTest < ActiveSupport::TestCase
  test "sends if should deliver" do
    user = create :user
    discussion_post = mock
    mail_type = :new_discussion_post

    mailer_action = mock(:deliver)
    NotificationsMailer.expects(:new_discussion_post).with(user, discussion_post).returns(mailer_action)
    notification = DeliversEmail.deliver(user, mail_type, discussion_post)
  end

  test "doesn't send if shouldn't deliver" do
    user = create :user
    user.communication_preferences.update!(email_on_new_discussion_post: false)
    discussion_post = mock
    mail_type = :new_discussion_post

    NotificationsMailer.expects(:new_discussion_post).never
    notification = DeliversEmail.deliver(user, mail_type, discussion_post)
  end

  test "raises with invalid mail type" do
    assert_raises DeliversEmail::UnknownMailTypeError do
      DeliversEmail.deliver(create(:user), :foobar)
    end
  end
end
require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:user_one) { create(:user, email: 'tester@groundhog.com') }
  let(:user_two) { create(:user, email: 'tester2@groundhog.com') }

  it 'allows user to subsribe another user' do
    user_one.subscribe!(user_two)

    expect(user_two.subscribers.include?(user_one)).to be_truthy
  end

  it 'allows user to unsubscribe another user' do
    user_one.subscribe!(user_two)
    user_one.unsubscribe(user_two)

    expect(user_one.subscribed_to.include?(user_two)).to be_falsey
  end

  it 'does not allow user to subscribe another user twice' do
    Subscription.create!(subscriber_id: user_one.id, user: user_two)

    expect(Subscription.new(subscriber_id: user_one.id, user: user_two).save).to be_falsey
  end
end

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }
  let(:user) { create(:user, email: 'tester@groundhog.com') }

  it 'is valid with valid post' do
    expect(Post.new(title: 'test title', content: 'Content here', user_id: user.id)).to be_valid
  end

  it 'is invalid when no author' do
    expect(Post.new(title: 'test title', content: 'Content here')).to be_invalid
  end

  it 'can be like by a user' do
    real_user = User.find_or_create_by!(email: 'tester@groundhog.com', nickname: user.nickname)
    real_post = Post.find_or_create_by!(title: 'test', content: 'ooo', user: real_user)
    real_post.liked_by(real_user)

    expect(real_post.liked_by?(real_user)).to be_truthy
  end

  it 'would be dislike if liked twice' do
    real_user = User.find_or_create_by!(email: 'tester@groundhog.com', nickname: user.nickname)
    real_post = Post.find_or_create_by!(title: 'test', content: 'ooo', user: real_user)
    real_post.liked_by(real_user)
    real_post.liked_by(real_user)

    expect(real_post.liked_by?(real_user)).to be_falsey
  end
end

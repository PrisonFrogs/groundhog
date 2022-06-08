require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  it 'is valid with valid post' do
    expect(Post.new(title: 'test title', content: 'Content here', user_id: user.id)).to be_valid
  end

  it 'is invalid when no author' do
    expect(Post.new(title: 'test title', content: 'Content here')).to be_invalid
  end
end

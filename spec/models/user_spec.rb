require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid user' do
    expect(User.new(email: 'test@test.com',
                    nickname: 'Joey',
                    password: 'pwd123123',
                    bio: 'I am the king',
                    gender: 2,
                    age: 22,
                    location: '300 Swanston St, Melbourne VIC, 3000')).to be_valid
  end

  it 'is not valid without a email' do
    expect(User.new(email: nil)).to_not be_valid
  end

  it 'is not valid without a nickname' do
    expect(User.new(nickname: nil)).to_not be_valid
  end

  it 'is not valid without a password' do
    expect(User.new(password_digest: nil)).to_not be_valid
  end

  it 'is not valid with a incorrect email formate' do
    expect(User.new(email: '123')).to_not be_valid
  end
end

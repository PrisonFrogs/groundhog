require 'rails_helper'

RSpec.describe User, type: :model do
  it 'must have an email' do
    expect(User.new).to be_invalid
  end
end

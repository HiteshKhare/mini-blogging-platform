require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(email: 'test@example.com', password: 'password123') }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'sets default role to guest' do
    user = User.new(email: 'user@example.com', password: 'password123')
    user.save
    expect(user.role).to eq('guest')
  end
end

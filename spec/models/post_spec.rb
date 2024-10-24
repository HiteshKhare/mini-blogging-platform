require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(email: 'user@example.com', password: 'password123') }
  subject { Post.new(title: 'Test Title', body: 'Test Body', user: user) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a body' do
    subject.body = nil
    expect(subject).to_not be_valid
  end

  it 'belongs to a user' do
    expect(subject.user).to eq(user)
  end
end

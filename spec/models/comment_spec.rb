require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post) { Post.create(title: 'Test Title', body: 'Test Body') }
  subject { Comment.new(body: 'Test Comment', post: post) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a body' do
    subject.body = nil
    expect(subject).to_not be_valid
  end

  it 'belongs to a post' do
    expect(subject.post).to eq(post)
  end
end

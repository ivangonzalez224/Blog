require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  
  before { subject.save }

  it 'name should be present' do
    expect(subject).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    expect(user).to_not be_valid
  end

  it 'is invalid with a negative posts_counter' do
    user = User.new(name: 'Jim', posts_counter: -1)
    expect(user).to_not be_valid
  end
  
  it 'is invalid with a non-integer posts_counter' do
    user = User.new(name: 'Jim', posts_counter: 2.1)
    expect(user).to_not be_valid
  end
end

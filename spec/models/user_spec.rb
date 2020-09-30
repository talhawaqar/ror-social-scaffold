require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) do
    User.create(email: 'talha13@gmail.com',
                name: 'Talha', password: '123456')
  end
  let!(:user2) { User.create }

  DatabaseCleaner.start

  describe User do
    context 'validates name' do
      it { should validate_presence_of(:name) }
    end

    context 'validates email' do
      it { should validate_presence_of(:email) }
      it { should allow_value('abc@gmail.com').for(:email) }
      it { should_not allow_value('abcgmail.com').for(:email) }
    end

    context 'validates associations' do
      it { should have_many(:posts) }
      it { should have_many(:comments) }
      it { should have_many(:friendships) }
      it { should have_many(:inverse_friendships) }
    end
  end
  DatabaseCleaner.clean
end

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }
  let(:other_user) { create(:user) }
  let(:other_task) { create(:task, user: other_user) }
  
  it { should have_many(:tasks).dependent(:destroy) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '#is_author_of?' do
    it 'returns true when user is the author of the task' do
      expect(user.is_author_of?(task)).to be true
    end

    it 'returns false when user is not the author of the task' do
      expect(user.is_author_of?(other_task)).to be false
    end
  end
end

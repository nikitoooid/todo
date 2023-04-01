require 'rails_helper'

RSpec.describe User do
  it { should have_many(:tasks).dependent(:destroy) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '#author_of?' do
    it 'returns true when user is the author of the task' do
      user = create(:user)
      task = create(:task, user: user)

      expect(user.author_of?(task)).to be true
    end

    it 'returns false when user is not the author of the task' do
      user = create(:user)
      another_user = create(:user)
      another_task = create(:task, user: another_user)

      expect(user.author_of?(another_task)).to be false
    end
  end
end

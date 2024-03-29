require 'rails_helper'

RSpec.describe Task do
  it { should belong_to :user }
  it { should validate_presence_of :title }

  describe '#change_status' do
    it 'changes task is_done status to false if it was true' do
      user = create(:user)
      task = create(:task, :done, user: user)

      task.change_status

      expect(task.is_done).to be false
    end

    it 'changes task is_done status to true if it was false' do
      user = create(:user)
      task = create(:task, user: user)

      task.change_status

      expect(task.is_done).to be true
    end
  end

  describe '#overdue?' do
    it 'returns true if task is overdue' do
      user = create(:user)
      task = create(:task, due_date: Date.yesterday, user: user)

      expect(task.overdue?).to be true
    end

    it 'returns false if task is not overdue' do
      user = create(:user)
      task = create(:task, due_date: Date.tomorrow, user: user)

      expect(task.overdue?).to be false
    end

    it 'returns false if task has not due date' do
      user = create(:user)
      task = create(:task, user: user)

      expect(task.overdue?).to be false
    end
  end
end

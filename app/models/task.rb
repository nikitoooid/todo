class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  def change_status
    self.update(is_done: !self.is_done)
  end

  def overdue?
    due_date.present? && !is_done && due_date < Time.current
  end
end

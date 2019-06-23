class Task < ApplicationRecord
  belongs_to :user

  validates :priority, presence: true, length: { maximum: 1 }
  validates :content, presence: true, length: { maximum: 100 }
end
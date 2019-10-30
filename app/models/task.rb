class Task < ApplicationRecord
  belongs_to :user, optional: true
  
  validates :title, presence: true
  validates :detail, presence: true, length: { maximum: 100 }
end

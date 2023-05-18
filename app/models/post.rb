class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true

  scope :for_pagination, -> { includes(:user).order(created_at: :desc) }
end

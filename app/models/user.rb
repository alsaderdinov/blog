class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable, :rememberable, :validatable

  def author_of?(resource)
    id == resource.user_id
  end
end

class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  devise :database_authenticatable, :registerable, :rememberable, :validatable
end

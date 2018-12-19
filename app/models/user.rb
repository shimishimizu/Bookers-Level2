class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  attachment :user_image

  validates :name, presence: true
  validates :name, length: {in: 2..20}
  validates :introduction, length: {maximum: 50}
end

class User < ApplicationRecord
  validates :name, presence: true
  validates :profile, presence: true
  validates :occupation, presence: true
  validates :position, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :prototypes, dependent: :destroy
  has_many :comments, dependent: :destroy
end

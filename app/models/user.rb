class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  auto_strip_attributes :first_name, :last_name, squish: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}".strip
  end
end

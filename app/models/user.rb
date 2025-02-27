class User < ApplicationRecord
  has_merit

  before_create :create_sash

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true

  has_many :games, dependent: :destroy
  has_many :flights, through: :games

  def create_sash
    self.sash = Sash.create
  end
end

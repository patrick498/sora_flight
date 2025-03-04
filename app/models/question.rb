class Question < ApplicationRecord
  belongs_to :game

  has_many :choices, dependent: :destroy

  validates :content, presence: true
end

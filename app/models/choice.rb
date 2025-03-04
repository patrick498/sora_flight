class Choice < ApplicationRecord
  belongs_to :question

  has_many :guesses, dependent: :destroy

  validates :content, presence: true
end

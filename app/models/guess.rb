class Guess < ApplicationRecord
  belongs_to :user
  belongs_to :choice, optional: true # ✅ Allow a choice to exist without a guess
end

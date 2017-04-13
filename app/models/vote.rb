class Vote < ApplicationRecord
  belongs_to :suggestion

  validates :suggestion_id, presence: true
end

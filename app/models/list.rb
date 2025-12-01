class List < ApplicationRecord
  belongs_to :board
  has_many :cards, dependent: :destroy
  acts_as_list scope: :board
  validates :name, presence: true
end

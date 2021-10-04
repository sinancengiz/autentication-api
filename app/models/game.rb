class Game < ApplicationRecord

  # Model associations
  has_and_belongs_to_many :users

  # validation
  validates_presence_of :title
  validates_uniqueness_of :title

end

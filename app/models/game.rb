class Game < ApplicationRecord
    # validation
  validates_presence_of :title
end

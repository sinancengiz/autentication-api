class Game < ApplicationRecord

  # Model associations
  has_and_belongs_to_many :users

  # validation
  validates_presence_of :title
  validates_uniqueness_of :title
  validates_presence_of :created_by

  def destroy_game
    self.users.each do |user|
      user.current_game = nil
      user.save
    end
    self.users.clear
    self.destroy
  end
end

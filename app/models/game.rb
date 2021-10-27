class Game < ApplicationRecord

  # Model associations
  has_and_belongs_to_many :users
  has_and_belongs_to_many :castles

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

  def initial_castles
    [{
      name: 'Castle of the Winds',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    },
    {
      name: 'Castle of the Ice',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    },
    {
      name: 'Castle of the Fire',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    },
    {
      name: 'Castle of the Water',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    },
    {
      name: 'Castle of the Earth',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    },
    {
      name: 'Castle of the Air',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    },
    {
      name: 'Castle of the Heavens',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    },
    {
      name: 'Castle of the Stars',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    },
    {
      name: 'Castle of the Moon',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    },
    {
      name: 'Castle of the Sun',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    },
    {
      name: 'Castle of the Jupiter',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    },
    {
      name: 'Castle of the Saturn',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    },
    {
      name: 'Castle of the Uranus',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    },
    {
      name: 'Castle of the Neptune',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    },
    {
      name: 'Castle of the Pluto',
      population: 1000,
      idle_population: 400,
      army: 100,
      gold_worker: 100,
      farm_worker: 100,
      wood_worker: 100,
      stone_worker: 100,
      iron_worker: 100,
    }]
  end
end
